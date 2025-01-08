import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:isar/isar.dart';

class NetworkEndpointRepository extends INetworkEndpointRepository {
  NetworkEndpointRepository(this._isar);
  final Isar _isar;

  @override
  int update(NetworkEndpoint endpoint) {
    int id = -1;
    _isar.writeTxnSync(() => id = _isar.networkEndpoints.putSync(endpoint));
    return id;
  }
  @override
  List<int> updateAll(List<NetworkEndpoint> endpoints) {
    List<int> ids = [];
    _isar.writeTxnSync(() => ids = _isar.networkEndpoints.putAllSync(endpoints));
    return ids;
  }

  NetworkEndpoint _newEndpoint(String ip){
    NetworkEndpoint endpoint = NetworkEndpoint(ip: ip);
    update(endpoint);
    return endpoint;
  }

  @override
  NetworkEndpoint? getByIp(String ip, {bool createIfNull=false}) {
    NetworkEndpoint? endpoint = _isar.networkEndpoints.getByIpSync(ip);
    if(endpoint == null && createIfNull) endpoint = _newEndpoint(ip);
    return endpoint;
  }
  @override
  List<NetworkEndpoint> getAllByIp(List<String> ips) {
    List<NetworkEndpoint> endpoints = _isar.networkEndpoints.getAllByIpSync(ips).nonNulls.toList();
    for(var ip in ips.where((i) => !endpoints.any((e) => e.ip == i))){
      endpoints.add(_newEndpoint(ip));
    }
    return endpoints;
  }
  @override
  Stream<List<NetworkEndpoint>> watchByIp(String ip) {
    return _isar.networkEndpoints.where().ipEqualTo(ip).watch(fireImmediately: true);
  }

  @override
  List<NetworkEndpoint> get(List<int> ids) {
    return _isar.networkEndpoints.getAllSync(ids).nonNulls.toList();
  }

  @override
  List<NetworkEndpoint> getByApplication(String applicationId){
    var scenarios = TestScenarioRepository(_isar).getForApplication(applicationId);
    List<NetworkEndpoint> endpoints = [];
    for(var scenario in scenarios){
      for(var constellation in scenario.testConstellations){
        for(var test in constellation.tests){
          endpoints.addAll(test.endpoints?.where((t) => !endpoints.any((e) => e.ip==t.ip)) ?? []);
        }
      }
    }
    endpoints.sort((a,b) => a.hostname != null && b.hostname != null ? compareHostnames(a.hostname!, b.hostname!) : (a.hostname ?? a.ip).compareTo(b.hostname ?? b.ip));
    return endpoints;
  }
}
