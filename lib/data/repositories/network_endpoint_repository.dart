import 'package:flutter/cupertino.dart';
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
}
