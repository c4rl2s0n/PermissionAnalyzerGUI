
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part '{{name.snakeCase()}}_cubit.freezed.dart';


class {{name.pascalCase()}}Cubit extends Cubit<{{name.pascalCase()}}State>{
  {{name.pascalCase()}}Cubit():super(const {{name.pascalCase()}}State());

}

@freezed
class {{name.pascalCase()}}State with _${{name.pascalCase()}}State {
const factory {{name.pascalCase()}}State() = _{{name.pascalCase()}}State;

}

