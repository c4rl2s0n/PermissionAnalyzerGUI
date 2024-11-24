import 'package:permission_analyzer_gui/common/keys.dart';
import 'package:permission_analyzer_gui/data/data.dart';

class GraphVertex {
  GraphVertex({
    required this.id,
    this.group,
    this.endpoint,
    this.unique = false,
    this.common = false,
    this.size = 0.5,
    this.connectedGroups = 0,
  }) : assert(group != null && endpoint == null ||
            group == null && endpoint != null);

  String id;
  TrafficGroup? group;
  TrafficEndpoint? endpoint;

  String get name => group?.name ?? endpoint!.name;
  List<String> get tags => [
        if (group != null) ...[...group!.tags, tGroup],
        if (endpoint != null) ...[if(endpoint!.hostname != null) tHostname, tEndpoint],
        if (unique) tUnique,
        if (common) tCommon,
      ];
  dynamic get data => group ?? endpoint;
  bool unique;
  bool common;
  double size;
  int connectedGroups;

  // TODO:
  //  - for endpoints: count number of connected groups (map to 0.0-1.0)
  //  - highlight groups with unique endpoints
  //  - highlight endpoints with only one group
}
