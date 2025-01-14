import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';

class ConfigDialog extends StatelessWidget {
  ConfigDialog(this.analysisCubit, {super.key}) {
    configCubit = analysisCubit.state.configCubit;
  }

  final AnalysisCubit analysisCubit;
  late final AnalysisConfigCubit configCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: analysisCubit,
      child: BlocProvider.value(
        value: configCubit,
        child: BlocBuilder<AnalysisConfigCubit, AnalysisConfigState>(
          builder: (context, state) {
            return CustomDialog(
              title: "Overview Settings",
              expand: false,
              content: _options(context),
              icon: Icon(context.icons.settings),
              actions: const [CloseButton()],
            );
          },
        ),
      ),
    );
  }

  Widget _options(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _showPort(context),
        _showSniInDomain(context),
        _showGeolocation(context),
        _showTrafficLoadInPackets(context),
        _groupConnections(context),
      ].insertBetweenItems(() => Margin.horizontal(context.constants.largeSpacing)),
    );
  }

  Widget _showSniInDomain(BuildContext context) {
    return SimpleSetting(
      name: "Show Server Name in Domain Column",
      description:
          "If a Server Name (SNI) is present, show it instead of hostname.",
      action: BlocBuilder<AnalysisConfigCubit, AnalysisConfigState>(
        buildWhen: (oldState, state) =>
            oldState.sniInDomain != state.sniInDomain,
        builder: (context, state) {
          return Switch(
            value: state.sniInDomain,
            onChanged: (v) => context.analysisConfigCubit.setSniInDomain(v),
          );
        },
      ),
    );
  }

  Widget _showPort(BuildContext context) {
    return SimpleSetting(
      name: "Show Port Column",
      action: BlocBuilder<AnalysisConfigCubit, AnalysisConfigState>(
        buildWhen: (oldState, state) => oldState.showPort != state.showPort,
        builder: (context, state) {
          return Switch(
            value: state.showPort,
            onChanged: (v) => context.analysisConfigCubit.setShowPort(v),
          );
        },
      ),
    );
  }

  Widget _showGeolocation(BuildContext context) {
    return SimpleSetting(
      name: "Show Location Columns",
      action: BlocBuilder<AnalysisConfigCubit, AnalysisConfigState>(
        buildWhen: (oldState, state) =>
            oldState.showLocation != state.showLocation,
        builder: (context, state) {
          return Switch(
            value: state.showLocation,
            onChanged: (v) => context.analysisConfigCubit.setShowLocation(v),
          );
        },
      ),
    );
  }

  Widget _showTrafficLoadInPackets(BuildContext context) {
    return SimpleSetting(
      name: "Show Traffic Load in Packets",
      action: BlocBuilder<AnalysisConfigCubit, AnalysisConfigState>(
        buildWhen: (oldState, state) =>
            oldState.trafficLoadInPackets != state.trafficLoadInPackets,
        builder: (context, state) {
          return Switch(
            value: state.trafficLoadInPackets,
            onChanged: (v) =>
                context.analysisConfigCubit.setTrafficLoadInPackets(v),
          );
        },
      ),
    );
  }

  Widget _groupConnections(BuildContext context) {
    return SimpleSetting(
      name: "Group Connections",
      description: "Group connections by Server Name (SNI), Domain or IP",
      action: BlocBuilder<AnalysisConfigCubit, AnalysisConfigState>(
        buildWhen: (oldState, state) =>
            oldState.groupConnections != state.groupConnections,
        builder: (context, state) {
          return Switch(
            value: state.groupConnections,
            onChanged: (v) => analysisCubit.setGrouped(v),
          );
        },
      ),
    );
  }

  static Future showSettings(
    BuildContext context,
    AnalysisCubit analysisCubit,
  ) async {
    return await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ConfigDialog(analysisCubit),
    );
  }
}
