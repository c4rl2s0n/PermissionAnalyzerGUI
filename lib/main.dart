import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'app_root.dart';
import 'main_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String documentsDirectory = join(
    (await getApplicationDocumentsDirectory()).path,
    "PermissionAnalyzerGUI",
  );
  await Directory(documentsDirectory).create(recursive: true);
  String databaseFilename = "permission_analyzer_db.isar";

  runApp(
    ModularApp(
      module: MainModule(
        applicationDocumentDirectory: documentsDirectory,
        databaseFilename: databaseFilename,
      ),
      child: const AppRoot(),
    ),
  );
}
