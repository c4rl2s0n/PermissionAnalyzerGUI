import 'package:permission_analyzer_gui/data/data.dart';

abstract class ITestApplicationRepository{
  List<TestApplication> getAll();
  Stream<List<TestApplication>> watchAll();
  TestApplication? get(String id);
  void delete(String id);
  void update(TestApplication application);
}