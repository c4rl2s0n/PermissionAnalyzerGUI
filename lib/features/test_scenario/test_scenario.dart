import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/repositories/repositories.dart';
import 'package:permission_analyzer_gui/data/models/models.dart' as models;
import 'package:permission_analyzer_gui/features/features.dart';

import 'logic/logic.dart';
import 'widgets/widgets.dart';

class TestScenario extends StatelessWidget {
  const TestScenario(this.scenario, {super.key});

  final models.TestScenario scenario;

  // Once tests have been created and were executed, the settings can not be changed anymore!

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TestScenarioCubit(
        testScenarioRepository: Modular.get<ITestScenarioRepository>(),
        networkEndpointRepository: Modular.get<INetworkEndpointRepository>(),
        sessionCubit: context.session,
        settingsCubit: context.settings,
        testScenario: scenario,
      ),
      child: PageComponentFactory.scaffold(
        context,
        appBar: PageComponentFactory.appBar(context,
            title: context.strings.testScenario,
            actions: [
              PageComponentFactory.navigationIconButton(
                context,
                () => Analysis([scenario]),
                context.icons.analysis,
              ),
              PageComponentFactory.navigationIconButton(
                context,
                () => const SettingsPage(),
                context.icons.settings,
              ),
            ]),
        body: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocListener<TestScenarioCubit, TestScenarioState>(
      listenWhen: (oldState, state) => oldState.loading != state.loading,
      listener: _onLoading,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _leftSide(context),
                _rightSide(context),
              ].insertBetweenItems(
                  () => Margin.horizontal(context.constants.largeSpacing)),
            ),
          ),
          const TestScenarioActions(),
        ].insertBetweenItems(() => Margin.vertical(context.constants.spacing)),
      ),
    );
  }

  Widget _layoutSide(BuildContext context, {required List<Widget> children}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children.insertBetweenItems(
          () => Margin.vertical(context.constants.spacing),
        ),
      ),
    );
  }

  Widget _leftSide(BuildContext context) {
    return _layoutSide(context, children: <Widget>[
      const ScenarioDetails(),
      const Expanded(child: TestConstellationsOverview()),
    ]);
  }

  Widget _rightSide(BuildContext context) {
    return _layoutSide(context, children: [
      const Expanded(child: PermissionSelector()),
      const RecordingOptions(),
    ]);
  }

  void _onLoading(BuildContext context, TestScenarioState state) {
    if (!state.loading) return;
    // open loading dialog
    var cubit = context.testScenarioCubit;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => LoadingDialog(
              cubit,
              title: state.loadingInfo,
            ));
  }
}
