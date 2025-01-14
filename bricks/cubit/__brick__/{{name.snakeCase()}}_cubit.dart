
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:permission_analyzer_gui/data/models/models.dart';

part '{{name.snakeCase()}}_cubit.freezed.dart';


class {{name.pascalCase()}}Cubit extends Cubit<{{name.pascalCase()}}State>{
  {{name.pascalCase()}}Cubit({
{{#repository}}required this.repository,{{/repository}}
    required this.model,
{{#settings}}required this.settingsCubit,{{/settings}}
  }):super(const {{name.pascalCase()}}State());
  {{#repository}}
  final I{{name.pascalCase()}}Repository repository;
{{/repository}}
  final {{name.pascalCase()}} model;
{{#settings}}
  final SettingsCubit settingsCubit;
  SettingsState get _settings => settingsCubit.state;
{{/settings}}
}

@freezed
class {{name.pascalCase()}}State with _${{name.pascalCase()}}State {
  const {{name.pascalCase()}}State._();
  const factory {{name.pascalCase()}}State({
    required String name,
  }) = _{{name.pascalCase()}}State;

  factory {{name.pascalCase()}}State.empty() => const {{name.pascalCase()}}State(
    name: "",
  );
}

