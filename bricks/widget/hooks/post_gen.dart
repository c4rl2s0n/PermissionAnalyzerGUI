import 'dart:io';
import 'package:mason/mason.dart';

void run(HookContext context) {
  String name = context.vars['name'] as String;

  // add export reference to models
  File modelsFile = File('widgets.dart');
  modelsFile.writeAsStringSync(
    "\nexport '${name.snakeCase}.dart';",
    mode: FileMode.append,
  );

  // format the code
  Process.runSync("dart", ["format", "lib"]);
}
