import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';

import '../logic/logic.dart';

class {{name.pascalCase()}} extends StatelessWidget {
  const {{name.pascalCase()}}({super.key});

  @override
  Widget build(BuildContext context) {
    {{#useBloc}}return BlocBuilder<{{bloc.pascalCase()}}Cubit, {{bloc.pascalCase()}}State>(
      buildWhen: (oldState, state) => oldState != state,
      builder: (context, state) => Placeholder(),
    );{{/useBloc}}
    {{^useBloc}}return Placeholder();{{/useBloc}}
  }
}