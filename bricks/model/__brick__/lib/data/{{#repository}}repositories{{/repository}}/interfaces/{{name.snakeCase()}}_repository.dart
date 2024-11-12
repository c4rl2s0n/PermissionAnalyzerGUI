import 'package:permission_analyzer_gui/data/data.dart';

abstract class I{{name.pascalCase()}}Repository{
  List<{{name.pascalCase()}}> getAll();
  void update({{name.pascalCase()}} entity);
}