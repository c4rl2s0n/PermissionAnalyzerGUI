import 'package:isar/isar.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'firewall_setting.g.dart';

@embedded
class FirewallSetting {
  FirewallSetting({
    this.ip = "",
    this.blocked = false,
    this.endpoint,
  });
  String ip;
  bool blocked;

  @ignore
  NetworkEndpoint? endpoint;

  @ignore
  FirewallSetting get toggle => FirewallSetting(
      ip: ip,
      blocked: !blocked,
      endpoint: endpoint,
    );
  @ignore
  FirewallSetting get reset => FirewallSetting(
      ip: ip,
      blocked: false,
      endpoint: endpoint,
    );
}
