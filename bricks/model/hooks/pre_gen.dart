import 'package:mason/mason.dart';

void run(HookContext context) {
  final color = context.vars['isar_type'] as String;

  // Set boolean variables based on the selected color

  context.vars['isCollection'] = color == 'collection';
  context.vars['isEmbedded'] = color == 'embedded';
  context.vars['needIsar'] = context.vars['isCollection'] || context.vars['isEmbedded'];
}
