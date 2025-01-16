import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/screen_record_overview/logic/logic.dart';

import 'widgets/widgets.dart';

class ScreenRecordOverview extends StatelessWidget {
  const ScreenRecordOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(
      builder: (context, analysisState) => BlocProvider(
        create: (context) =>
            ScreenRecorderOverviewCubit(analysisState.enabledTests),
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
        const PlaybackControls(),
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
            ScreenRecorderOverviewCubit overviewCubit = context.overviewCubit;
            return GridView.count(
              crossAxisCount: count,
              mainAxisSpacing: spacing,
              crossAxisSpacing: spacing,
              children: tests
                  .where((t) => File(t.screenRecordPath!).existsSync())
                  .map((t) => TestRunLiveView(
                        t,
                        size: Size.square(state.videoSize),
                        onDurationUpdate: (p) => overviewCubit.updatePlaybackPosition(p),
                        initialIsPlaying: state.isPlaying,
                        initialPlaybackSpeed: state.playbackSpeed,
                        initialPosition: state.position,
                        resetStream: overviewCubit.resetStream,
                        playPauseStream: overviewCubit.playPauseStream,
                        playbackSpeedStream: overviewCubit.playbackSpeedStream,
                        seekToStream: overviewCubit.seekToStream,
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
          height: 300,
        );
      },
    );
  }
}
