import 'package:permission_analyzer_gui/data/models/network_endpoint.dart';

abstract class INetworkEndpointRepository {
  List<NetworkEndpoint> get(List<int> ids);
  List<NetworkEndpoint> getByApplication(String applicationId);
  NetworkEndpoint getByIp(String ip);
  List<NetworkEndpoint> getAllByIp(List<String> ips);
  int update(NetworkEndpoint endpoint);
  List<int> updateAll(List<NetworkEndpoint> endpoints);
}
