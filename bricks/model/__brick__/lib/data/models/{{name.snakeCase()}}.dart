{{#needIsar}}
import 'package:isar/isar.dart';
{{/needIsar}}
part '{{name.snakeCase()}}.g.dart';

{{#isCollection}}
@collection
{{/isCollection}}
{{#isEmbedded}}
@embedded
{{/isEmbedded}}
class {{name.pascalCase()}} {
  {{name.pascalCase()}}({
    this.property = "",
  });
  {{#isCollection}}
  Id id = Isar.autoIncrement;
  {{/isCollection}}
  String property;
}