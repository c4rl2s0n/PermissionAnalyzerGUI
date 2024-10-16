import 'package:flutter_template/data/data.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'isar_data_module.dart';

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
  }

  @override
  void exportedBinds(i) {}
}
