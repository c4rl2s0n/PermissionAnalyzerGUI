import 'package:permission_analyzer_gui/data/data.dart';
import 'package:isar/isar.dart';

class {{name.pascalCase()}}Repository extends I{{name.pascalCase()}}Repository{
  {{name.pascalCase()}}Repository(this._isar);
  final Isar _isar;
  List<{{name.pascalCase()}}> getAll(){
    return _isar.{{name.lowerCase}}.where().findAllSync();
  }
  void update({{name.pascalCase()}} entity){
    _isar.writeSync(() => _isar.{{name.lowerCase}}.update(entity));
  }
}