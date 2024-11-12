import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) {
  String name = context.vars['name'] as String;

  // add export reference to features
  File modelsFile = File('lib/features/features.dart');
  modelsFile.writeAsStringSync(
    "\nexport '${name.snakeCase}/${name.snakeCase}.dart';",
    mode: FileMode.append,
  );

  // format the code and run the build_runner
  Process.runSync("dart", ["format", "lib"]);
  Process.runSync("dart", ["run", "build_runner", "build"]);
}
