import 'package:isar/isar.dart';

part 'analysis_config.g.dart';

@embedded
class AnalysisConfig {
  AnalysisConfig({
    this.trafficLoadInPackets = false,
    this.showTestsInGroupTable = true,
    this.groupConnections = false,
    this.showLocation = true,
    this.showPort = false,
    this.sniInDomain = true,
  });
  bool trafficLoadInPackets;
  bool showTestsInGroupTable;
  bool groupConnections;
  bool showLocation;
  bool showPort;
  bool sniInDomain;
}
