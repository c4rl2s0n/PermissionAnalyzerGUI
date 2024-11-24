import 'package:permission_analyzer_gui/data/data.dart';
import 'package:isar/isar.dart';

class NetworkEndpointRepository extends INetworkEndpointRepository {
  NetworkEndpointRepository(this._isar);
  final Isar _isar;

  @override
  void update(NetworkEndpoint endpoint) {
    _isar.writeTxnSync(() => _isar.networkEndpoints.putSync(endpoint));
  }

  @override
  NetworkEndpoint? getByIp(String ip) {
    return _isar.networkEndpoints.getByIpSync(ip);
  }
}
