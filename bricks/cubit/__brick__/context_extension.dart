import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '{{name.snakeCase()}}_cubit.dart';


extension Ctx{{name.pascalCase()}}Cubit on BuildContext {
  {{name.pascalCase()}}Cubit get {{name.lowerCase()}}Cubit =>
      read<{{name.pascalCase()}}Cubit>();
}
