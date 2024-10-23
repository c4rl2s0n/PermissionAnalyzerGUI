import 'package:isar/isar.dart';

part 'settings.g.dart';

@collection
class Settings {
  Settings({
    this.isDarkMode = true,
    this.language = "en",
    this.workingDirectory,
    this.adbPath,
    this.tsharkPath,
    this.recorderPath,
    this.recorderDestinationPath,
    this.inputRecordDestinationPath,
  });

  Id id = 1;
  bool isDarkMode;
  String language;

  String? workingDirectory;
  String? adbPath;
  String? tsharkPath;
  String? recorderPath;
  String? recorderDestinationPath;
  String? inputRecordDestinationPath;
}
