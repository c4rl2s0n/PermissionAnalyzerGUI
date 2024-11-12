import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) {
  String name = context.vars['name'] as String;

  // add export reference to models
  File modelsFile = File('lib/data/models/models.dart');
  modelsFile.writeAsStringSync(
    "export '${name.snakeCase}.dart';",
    mode: FileMode.append,
  );

  // create repository
  if (context.vars['repository']) {
    File repositoriesFile = File('lib/data/repositories/repositories.dart');
    repositoriesFile.writeAsStringSync(
      "export 'interfaces/${name.snakeCase}_repository.dart';\n",
      mode: FileMode.append,
    );
    repositoriesFile.writeAsStringSync(
      "export '${name.snakeCase}_repository.dart';\n\n",
      mode: FileMode.append,
    );

    String text = "";
    String pattern = "";

    // add scheme to isar data module
    File file = File('lib/data/isar_data_module.dart');
    text = file.readAsStringSync();
    pattern = r"(?<!return Isar.openSync\(.*Schema,) (?=])";
    RegExp regex = RegExp(pattern);
    RegExpMatch? match = regex.firstMatch(text);
    if (match != null) {
      text =
          "${text.substring(0, match.start)}${name.pascalCase}Scheme\n${text.substring(match.end)},";
    }
    file.writeAsStringSync(text);

    // add scheme to isar database repository module
    file = File('lib/data/isar_database_repository_module.dart');
    text = file.readAsStringSync();
    pattern = r"(?<=exportedBinds(.|\n)*) (?=})";
    regex = RegExp(pattern);
    match = regex.firstMatch(text);
    if (match != null) {
      text =
          "${text.substring(0, match.start)}i.addSingleton<I${name.pascalCase}Repository>(${name.pascalCase}Repository.new);\n${text.substring(match.end)}";
    }
    file.writeAsStringSync(text);

    // add scheme to isar database isolate repository module
    file = File('lib/data/isar_database_isolate_repository_module.dart');
    text = file.readAsStringSync();
    pattern = r"(?<=binds(.|\n)*) (?=})";
    regex = RegExp(pattern);
    match = regex.firstMatch(text);
    if (match != null) {
      text =
          "${text.substring(0, match.start)}i.addSingleton<I${name.pascalCase}Repository>(${name.pascalCase}Repository.new);\n${text.substring(match.end)}";
    }
    file.writeAsStringSync(text);
  }

  // format the code and run the build_runner
  Process.runSync("dart", ["format", "lib"]);
  //Process.runSync("dart", ["run", "build_runner", "build"]);
}
