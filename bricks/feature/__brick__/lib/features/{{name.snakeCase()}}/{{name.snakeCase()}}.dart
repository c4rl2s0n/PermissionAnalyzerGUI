
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/models/models.dart' as models;
import 'package:permission_analyzer_gui/features/features.dart';

import 'logic/logic.dart';
import 'widgets/widgets.dart';


class {{name.pascalCase()}} extends StatelessWidget {
  const {{name.pascalCase()}}(this.model, {super.key});

  final models.{{name.pascalCase()}} model;

  @override
  Widget build(BuildContext context) {
    return PageComponentFactory.scaffold(
      context,
      appBar: PageComponentFactory.appBar(context,
          title: context.strings.testScenario,
          actions: [
            PageComponentFactory.navigationIconButton(
              context,
              const SettingsPage(),
            )
          ]),
      body: BlocProvider(
        create: (context) =>
          {{name.pascalCase()}}Cubit(
              {{#repository}}repository: Modular.get<I{{name.pascalCase()}}Repository>(),{{/repository}}
              {{#settings}}settingsCubit: context.settings,{{/settings}}
              model: model,
            ),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Placeholder();
  }

}