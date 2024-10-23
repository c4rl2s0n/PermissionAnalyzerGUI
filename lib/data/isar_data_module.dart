import 'package:flutter_modular/flutter_modular.dart';
import 'package:isar/isar.dart';

import 'package:permission_analyzer_gui/data/data.dart';

class IsarDataModule extends Module {
  IsarDataModule(this.applicationDocumentDirectory, this.databaseFilename);

  String applicationDocumentDirectory;
  String databaseFilename;

  @override
  void exportedBinds(Injector i) {
    i.addSingleton<Isar>(() => _openDatabaseSync());
    super.exportedBinds(i);
  }

  Isar _openDatabaseSync() {
    return Isar.openSync(
      [
        SettingsSchema,
        TestScenarioSchema,
      ],
      directory: applicationDocumentDirectory,
      name: databaseFilename.replaceAll(".isar", ""),
    );
  }
}
