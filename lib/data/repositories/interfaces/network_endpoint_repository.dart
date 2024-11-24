import 'package:permission_analyzer_gui/data/models/network_endpoint.dart';

abstract class INetworkEndpointRepository {
  NetworkEndpoint? getByIp(String ip);
  void update(NetworkEndpoint endpoint);
}
