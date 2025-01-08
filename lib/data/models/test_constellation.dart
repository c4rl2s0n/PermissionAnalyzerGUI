import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:isar/isar.dart';
import 'package:permission_analyzer_gui/common/helper.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'test_constellation.g.dart';

@embedded
class TestConstellation {
  TestConstellation({
    this.permissions = const [],
    this.blockedIPs = const [],
    this.testIds = const [],
    this.displayNameAppendix = "",
  }){
    uniqueIdentifier = _uniqueIdentifier;
  }

  List<PermissionSetting> permissions;
  List<String> blockedIPs;
  @ignore
  List<NetworkEndpoint>? blockedEndpoints;
  @ignore
  bool get hasEndpoints => blockedEndpoints != null && blockedEndpoints!.isNotEmpty;
  List<int> testIds;
  @ignore
  List<TestRun>? _tests;
  @ignore
  List<TestRun> get tests => _tests ?? [];
  set tests(List<TestRun> value) {
    _tests = value;
  }

  @ignore
  String get info {
    String info = 'Permissions:\n';
    info += permissions
        .where((p) => p.state == PermissionState.granted)
        .map((p) => p.permission)
        .join("\t\t\n");
    return info;
  }

  String get abbreviation {
    if (permissions.every((p) => p.state == PermissionState.granted)) {
      return "ALL";
    }
    String abbr = permissions
        .where((c) => c.state == PermissionState.granted)
        .map((c) => permissionToShortcut(c.permission))
        .join("_");
    if (abbr.isEmpty) abbr = "NONE";
    return abbr;
  }

  String displayNameAppendix;

  @ignore
  String get displayName {
    String n = abbreviation;
    if(blockedIPs.isNotEmpty){
     n += "_${blockedIPs.length}_$displayNameAppendix";
    }
    return n;
  }

  @ignore
  late String uniqueIdentifier;
  @ignore
  String get _uniqueIdentifier {
    String n = abbreviation;
    if(blockedIPs.isEmpty) return n;
    n += "_${blockedIPs.length}_";
    n += md5.convert(utf8.encode(blockedIPs.join("_"))).toString();
    return n;
  }

  bool equalTo(TestConstellation other) {
    if(abbreviation != other.abbreviation || blockedIPs.length != other.blockedIPs.length) return false;
    return uniqueIdentifier == other.uniqueIdentifier;
  }
}
