import 'package:isar/isar.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'traffic_connection.g.dart';

@embedded
class TrafficConnection {
  TrafficConnection({
    this.endpoint = const TrafficEndpoint(),
    this.outCount = 0,
    this.inCount = 0,
    this.outBytes = 0,
    this.inBytes = 0,
    this.protocols,
  });

  TrafficEndpoint endpoint;
  int outCount;
  int inCount;
  int get count => outCount + inCount;
  int outBytes;
  int inBytes;
  int get bytes => outBytes + inBytes;
  String? protocols;
}
