import 'package:isar/isar.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'traffic_connection.g.dart';

@embedded
class TrafficConnection {
  TrafficConnection({
    this.endpoint,
    this.testRunCount = 1,
    this.outCount = 0,
    this.inCount = 0,
    this.outBytes = 0,
    this.inBytes = 0,
    this.protocols,
  });

  TrafficEndpoint? endpoint;
  int testRunCount;

  String? protocols;
  String get flow =>
      "(${endpoint?.ip ?? "???"}, ${endpoint?.port ?? "???"}, $protocols)";

  int outCount;
  int inCount;
  int get countTotal => outCount + inCount;
  double get outCountAvg => testRunCount == 0 ? 0 : outCount / testRunCount;
  double get inCountAvg => testRunCount == 0 ? 0 : inCount / testRunCount;
  double get countAvg => outCountAvg + inCountAvg;
  int outBytes;
  int inBytes;
  int get bytesTotal => outBytes + inBytes;
  double get outBytesAvg => testRunCount == 0 ? 0 : outBytes / testRunCount;
  double get inBytesAvg => testRunCount == 0 ? 0 : inBytes / testRunCount;
  double get bytesAvg => outBytesAvg + inBytesAvg;

  TrafficConnection copy() {
    return TrafficConnection(
      endpoint: endpoint,
      testRunCount: testRunCount,
      protocols: protocols,
      outCount: outCount,
      inCount: inCount,
      outBytes: outBytes,
      inBytes: inBytes,
    );
  }
}
