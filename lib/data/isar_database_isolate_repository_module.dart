import 'package:permission_analyzer_gui/data/data.dart';
import 'package:flutter_modular/flutter_modular.dart';

class IsarDataIsolateRepositoryModule extends Module {
  IsarDataIsolateRepositoryModule(
      this.applicationDocumentDirectory, this.databaseFilename);

  String applicationDocumentDirectory;
  String databaseFilename;

  @override
  List<Module> get imports =>
      [IsarDataModule(applicationDocumentDirectory, databaseFilename)];

  @override
  void binds(Injector i) {
    i.addSingleton<ISettingsRepository>(SettingsRepository.new);
    i.addSingleton<ITestScenarioRepository>(TestScenarioRepository.new);
    i.addSingleton<ITestApplicationRepository>(TestApplicationRepository.new);
  }

  @override
  void exportedBinds(i) {}
}
