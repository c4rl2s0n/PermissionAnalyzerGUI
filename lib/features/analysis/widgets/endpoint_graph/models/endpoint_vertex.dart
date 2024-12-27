
import 'package:permission_analyzer_gui/common/keys.dart';
import 'package:permission_analyzer_gui/data/data.dart';

import 'models.dart';

class EndpointVertex extends GraphVertex {
  EndpointVertex({required super.id, required this.endpoint});

  INetworkEndpoint endpoint;

  @override
  List<String> get tags => [
    if (endpoint.hasHostname) tHostname,
    tEndpoint,
    if (unique) tUnique,
    if (common) tCommon,
  ];

  @override
  get data => endpoint;

  @override
  String get name => endpoint.name;
}