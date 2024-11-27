import 'package:isar/isar.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'traffic_connection.g.dart';

@embedded
class TrafficConnection {
  TrafficConnection({
    this.endpoint,
    this.packets = const [],
    this.testRunCount = 1,
    this.outCount = 0,
    this.inCount = 0,
    this.countTotal = 0,
    this.countAvg = 0,
    this.outBytes = 0,
    this.inBytes = 0,
    this.bytesTotal = 0,
    this.bytesAvg = 0,
    this.protocols,
  });

  TrafficEndpoint? endpoint;
  int testRunCount;

  String? protocols;
  String get protocolsString =>
      protocols == null ? "" : protocols!.replaceFirst("sll:ethertype:", "");
  String get flow =>
      "(${endpoint?.ip ?? "???"}, ${endpoint?.port ?? "???"}, $protocols)";

  List<NetworkPacket> packets;
  int outCount;
  int inCount;
  int countTotal; // => outCount + inCount;
  double get outCountAvg => testRunCount == 0 ? 0 : outCount / testRunCount;
  double get inCountAvg => testRunCount == 0 ? 0 : inCount / testRunCount;
  double countAvg; // => outCountAvg + inCountAvg;
  int outBytes;
  int inBytes;
  int bytesTotal; // => outBytes + inBytes;
  double get outBytesAvg => testRunCount == 0 ? 0 : outBytes / testRunCount;
  double get inBytesAvg => testRunCount == 0 ? 0 : inBytes / testRunCount;
  double bytesAvg; // => outBytesAvg + inBytesAvg;

  void countPackets() {
    outCount = 0;
    inCount = 0;
    countTotal = 0;
    countAvg = 0;
    outBytes = 0;
    inBytes = 0;
    bytesTotal = 0;
    bytesAvg = 0;
    if (endpoint == null) return;

    for (var packet in packets) {
      if (packet.ipDst == endpoint!.ip) {
        // packets going outwards to endpoint
        outCount++;
        outBytes += packet.size;
      } else if (packet.ipSrc == endpoint!.ip) {
        // packets coming in from endpoint
        inCount++;
        inBytes += packet.size;
      }
      countTotal++;
      bytesTotal++;
    }
    countAvg = countTotal / testRunCount;
    bytesAvg = bytesTotal / testRunCount;
  }

  TrafficConnection copy() {
    return TrafficConnection(
      endpoint: endpoint,
      testRunCount: testRunCount,
      protocols: protocols,
      outCount: outCount,
      inCount: inCount,
      countTotal: countTotal,
      countAvg: countAvg,
      outBytes: outBytes,
      inBytes: inBytes,
      bytesTotal: bytesTotal,
      bytesAvg: bytesAvg,
      packets: [...packets],
    );
  }
}
