import 'package:isar/isar.dart';

part 'network_packet.g.dart';

@embedded
class NetworkPacket {
  NetworkPacket({
    this.ipSrc = "",
    this.portSrc,
    this.ipDst = "",
    this.portDst,
    this.protocols,
    this.serverName,
    this.timeInMs = 0,
    this.size = 0,
  });

  int? timeInMs;
  @ignore
  DateTime? get timestamp =>
      timeInMs != null ? DateTime.fromMillisecondsSinceEpoch(timeInMs!) : null;
  String ipSrc;
  int? portSrc;
  @ignore
  String get src => "$ipSrc:$portSrc";
  String ipDst;
  int? portDst;
  @ignore
  String get dst => "$ipDst:$portDst";
  String? protocols;
  String? serverName;
  int size;
}
