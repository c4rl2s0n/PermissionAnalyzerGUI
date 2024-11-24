import 'package:isar/isar.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'test_application.g.dart';

@collection
class TestApplication {
  TestApplication({
    this.name = "",
    this.id = "",
    this.iconPath,
    this.fileDirectory = "",
  });

  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: false, type: IndexType.hash)
  String id;
  String name;
  String? iconPath;
  String fileDirectory;
}
