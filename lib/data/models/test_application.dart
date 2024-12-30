import 'package:isar/isar.dart';

part 'test_application.g.dart';

@collection
class TestApplication {
  TestApplication({
    this.name = "",
    this.device = "",
    this.id = "",
    this.iconPath,
    this.fileDirectory = "",
  });

  Id isarId = Isar.autoIncrement;

  @Index(unique: true, replace: false, type: IndexType.hash)
  String id;
  String device;
  String name;
  String? iconPath;
  String fileDirectory;
}
