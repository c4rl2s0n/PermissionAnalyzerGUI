import 'package:permission_analyzer_gui/data/data.dart';

class GraphVertex {
  GraphVertex({
    this.group,
    this.endpoint,
    this.unique = false,
    this.common = false,
    this.size = 0.5,
    this.connections = 0,
  }) : assert(group != null && endpoint == null ||
            group == null && endpoint != null);

  TrafficGroup? group;
  TrafficEndpoint? endpoint;
  String get name => group?.name ?? endpoint!.name;
  List<String> get tags => [
        if (group != null) 'group',
        if (endpoint != null) 'endpoint',
        if (unique) 'highlight',
        if (common) 'common',
      ];
  dynamic get data => group ?? endpoint;
  bool unique;
  bool common;
  double size;
  int connections;

  // TODO:
  //  - for endpoints: count number of connected groups (map to 0.0-1.0)
  //  - highlight groups with unique endpoints
  //  - highlight endpoints with only one group
}
