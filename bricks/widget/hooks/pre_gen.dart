import 'package:mason/mason.dart';

void run(HookContext context) {
  final bloc = context.vars['bloc'] as String;
  context.vars['useBloc'] = bloc.isNotEmpty || bloc.toLowerCase() == "none";
}
