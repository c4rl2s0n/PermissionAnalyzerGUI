import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/screen_record_overview/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/screen_record_overview/widgets/connection_live_chart.dart';

import 'widgets/widgets.dart';

class ScreenRecordOverview extends StatelessWidget {
  const ScreenRecordOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
      builder: (context, analysisState) => BlocProvider(
        create: (context) =>
            ScreenRecorderOverviewCubit(analysisState.visibleTests),
        child: BlocBuilder<ScreenRecorderOverviewCubit,
                ScreenRecorderOverviewState>(
            builder: (context, overviewState) =>
                _content(context, analysisState, overviewState)),
      ),
    );
  }

  Widget _content(
    BuildContext context,
    AnalysisState analysisState,
    ScreenRecorderOverviewState overviewState,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(child: _videoGrid(context, analysisState)),
        Margin.vertical(context.constants.largeSpacing),
        _liveChart(),
        _controls(context),
      ],
    );
  }

  Widget _videoGrid(BuildContext context, AnalysisState analysisState) {
    return BlocBuilder<ScreenRecorderOverviewCubit,
        ScreenRecorderOverviewState>(
      buildWhen: (oldState, state) => oldState.videoSize != state.videoSize,
      builder: (context, state) {
        List<TestRun> tests = analysisState.enabledGroups
            .fold(<TestRun>[], (all, g) => [...all, ...g.group.tests])
            .where((t) => t.screenRecordPath.notEmpty)
            .toList()
            .distinct;
        if (tests.isEmpty) return const Text("No Record");
        return LayoutBuilder(
          builder: (context, constraints) {
            double spacing = context.constants.spacing;
            int count =
                (constraints.maxWidth / (state.videoSize + spacing)).floor();
            return GridView.count(
              crossAxisCount: count,
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing,
              children: tests
                  .where((t) => File(t.screenRecordPath!).existsSync())
                  .map((t) => TestRunLiveView(
                        t,
                        size: Size.square(state.videoSize),
                        onDurationUpdate: (p) =>
                            context.overviewCubit.updatePlaybackPosition(p),
                restartStream: context.overviewCubit.restartStream,
                playPauseStream: context.overviewCubit.playPauseStream,
                seekToStream: context.overviewCubit.seekToStream,
                      ))
                  .toList(),
            );
          },
        );
      },
    );
  }

  Widget _liveChart() {
    return BlocBuilder<ScreenRecorderOverviewCubit,
        ScreenRecorderOverviewState>(
      buildWhen: (oldState, state) =>
          oldState.timelines != state.timelines ||
          oldState.position != state.position,
      builder: (context, state) {
        return ConnectionLiveChart(
          state.selectedTimelines,
          time: state.positionInSeconds,
        );
      },
    );
  }

  Widget _controls(BuildContext context) {
    return BlocBuilder<ScreenRecorderOverviewCubit,
        ScreenRecorderOverviewState>(
      buildWhen: (oldState, state) => oldState.isPlaying != state.isPlaying,
      builder: (context, state) {
        return Row(
          children: [
            const Expanded(child: SizedBox()),
            IconButton(
              onPressed: () => context.overviewCubit.togglePlay(),
              icon: Icon(
                state.isPlaying ? context.icons.pause : context.icons.play,
              ),
            ),
            IconButton(
              onPressed: () => context.overviewCubit.restartReplay(),
              icon: Icon(context.icons.restart),
            ),
            const Expanded(child: SizedBox()),
            _infoLegend(context),
          ],
        );
      },
    );
  }

  Widget _infoLegend(BuildContext context) {
    return BlocBuilder<ScreenRecorderOverviewCubit,
            ScreenRecorderOverviewState>(
        buildWhen: (oldState, state) => oldState.timelines != state.timelines,
        builder: (context, state) {
          return Tooltip(
            richMessage: WidgetSpan(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                ...state.timelines.where((t) => t.selected).map<Widget>(
                  (tl) => Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        context.icons.mapMarker,
                        color: tl.color,
                      ),
                      Margin.horizontal(context.constants.smallSpacing),
                      Text("${tl.test.name}: ${tl.name}")
                    ],
                  ),
                ),
              ]),
            ),
            child: Icon(context.icons.info),
          );
        });
  }
}
