
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
    if (endpoint is! SniEndpoint && endpoint.hasServerName) tServerName else if(!endpoint.hasServerName) tNoServerName,
    if (endpoint.hasHostname) tHostname else tNoHostname,
    if(!endpoint.hasServerName && !endpoint.hasHostname) tIpOnly,
    if (unique) tUnique else tNotUnique,
    if (common) tCommon else tNotCommon,
    if (endpoint is SniEndpoint) tSniEndpoint,
  ];

  @override
  get data => endpoint;

  @override
  String name;
}