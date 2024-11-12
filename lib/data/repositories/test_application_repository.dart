import 'package:permission_analyzer_gui/data/data.dart';
import 'package:isar/isar.dart';

class TestApplicationRepository extends ITestApplicationRepository {
  TestApplicationRepository(this._isar);
  final Isar _isar;

  @override
  List<TestApplication> getAll() {
    return _isar.testApplications.where().findAllSync();
  }

  @override
  Stream<List<TestApplication>> watchAll() {
    return _isar.testApplications.where().watch();
  }

  @override
  TestApplication? get(String id) {
    return _isar.testApplications.where().idEqualTo(id).findFirstSync();
  }

  @override
  void delete(String id) {
    _isar.writeTxnSync(() => _isar.testApplications.deleteByIdSync(id));
  }

  @override
  void update(TestApplication application) {
    _isar.writeTxnSync(() => _isar.testApplications.putSync(application));
  }
}
