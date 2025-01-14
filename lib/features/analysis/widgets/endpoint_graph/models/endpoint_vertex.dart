
import 'package:permission_analyzer_gui/common/keys.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/models/endpoint_group.dart';

import 'models.dart';

class EndpointVertex extends GraphVertex {
  EndpointVertex({required super.id, required this.endpoint, required this.name,});

  INetworkEndpoint endpoint;

  @override
  List<String> get tags => [
    tEndpoint,
    if (unique) tUnique,
    if (common) tCommon,
    if (endpoint is SniEndpoint) tServerName
    else if (endpoint.hasHostname) tHostname
    else tIpOnly,
  ];

  @override
  get data => endpoint;

  @override
  String name;
}