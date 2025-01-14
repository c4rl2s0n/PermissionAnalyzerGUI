import 'package:isar/isar.dart';

import 'analysis_config.dart';

part 'settings.g.dart';

@collection
class Settings {
  Settings({
    this.isDarkMode = true,
    this.language = "en",
    this.ignoreLocalTraffic = true,
    this.workingDirectory,
    this.adbPath,
    this.tsharkPath,
    this.recorderVersion,
    this.recorderPath,
    this.recorderDestinationPath,
    this.inputRecordDestinationPath,
    this.analysisConfig,
  }){
    analysisConfig ??= AnalysisConfig();
  }

  Id id = 1;
  bool isDarkMode;
  String language;

  bool ignoreLocalTraffic;
  String? workingDirectory;
  String? adbPath;
  String? tsharkPath;
  String? recorderVersion;
  String? recorderPath;
  String? recorderDestinationPath;
  String? inputRecordDestinationPath;

  AnalysisConfig? analysisConfig;
}
