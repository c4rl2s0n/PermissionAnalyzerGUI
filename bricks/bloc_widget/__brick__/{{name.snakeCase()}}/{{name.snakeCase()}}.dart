import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';

import 'logic/logic.dart';


class {{name.pascalCase()}} extends StatelessWidget {
  const {{name.pascalCase()}}(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
  return BlocProvider(
        create: (context) => {{name.pascalCase()}}Cubit(),
        child: _buildContent(context),
      );
  }

  Widget _buildContent(BuildContext context) {
    return Placeholder();
  }

}