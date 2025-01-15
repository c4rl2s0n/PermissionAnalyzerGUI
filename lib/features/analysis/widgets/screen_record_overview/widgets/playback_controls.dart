import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/screen_record_overview/logic/logic.dart';

class PlaybackControls extends StatelessWidget {
  const PlaybackControls({super.key});

  @override
  Widget build(BuildContext context) {
    return _controls(context);
  }

  Widget _controls(BuildContext context) {
    double controlsSize = 50;
    return BlocBuilder<ScreenRecorderOverviewCubit,
        ScreenRecorderOverviewState>(
      buildWhen: (oldState, state) => oldState.isPlaying != state.isPlaying,
      builder: (context, state) {
        return Row(
          children: [
            const Expanded(child: SizedBox()),
            _playbackSpeedSlider(),
            const Expanded(child: SizedBox()),
            IconButton(
              onPressed: () => context.overviewCubit.togglePlay(),
              icon: Icon(
                size: controlsSize,
                state.isPlaying ? context.icons.pause : context.icons.play,
              ),
            ),
            IconButton(
              onPressed: () => context.overviewCubit.resetReplay(),
              icon: Icon(
                size: controlsSize,
                context.icons.restart,
              ),
            ),
            const Expanded(child: SizedBox()),
            _videoSizeSlider(),
            const Expanded(child: SizedBox()),
            _infoLegend(),
          ],
        );
      },
    );
  }

  Widget _playbackSpeedSlider() {
    double sizeSteps = 0.1;
    double defaultValue = 1;
    return SizedBox(
      width: 300,
      child:
          BlocBuilder<ScreenRecorderOverviewCubit, ScreenRecorderOverviewState>(
        buildWhen: (oldState, state) =>
            oldState.playbackSpeed != state.playbackSpeed,
        builder: (context, state) => Row(
          children: [
            IconButton(
              onPressed: () => context.overviewCubit
                  .setPlaybackSpeed(state.playbackSpeed - sizeSteps),
              icon: Icon(context.icons.speed, size: 14),
            ),
            GestureDetector(
              onSecondaryTap: () => context.overviewCubit.setPlaybackSpeed(defaultValue),
              child: Slider(
                value: state.playbackSpeed,
                divisions: ((maxVideoSize - minVideoSize) / sizeSteps).floor(),
                min: minPlaybackSpeed,
                max: maxPlaybackSpeed,
                onChanged: (s) => context.overviewCubit.setPlaybackSpeed(s),
              ),
            ),
            IconButton(
              onPressed: () => context.overviewCubit
                  .setPlaybackSpeed(state.playbackSpeed + sizeSteps),
              icon: Icon(context.icons.speed, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _videoSizeSlider() {
    int sizeSteps = 10;
    double defaultValue = 400;
    return SizedBox(
      width: 300,
      child:
          BlocBuilder<ScreenRecorderOverviewCubit, ScreenRecorderOverviewState>(
        buildWhen: (oldState, state) => oldState.videoSize != state.videoSize,
        builder: (context, state) => Row(
          children: [
            IconButton(
              onPressed: () => context.overviewCubit
                  .setVideoSize(state.videoSize - sizeSteps),
              icon: Icon(context.icons.screen, size: 14),
            ),
            GestureDetector(
              onSecondaryTap: () =>
                  context.overviewCubit.setVideoSize(defaultValue),
              child: Slider(
                value: state.videoSize,
                divisions: ((maxVideoSize - minVideoSize) / sizeSteps).floor(),
                min: minVideoSize,
                max: maxVideoSize,
                onChanged: (s) => context.overviewCubit.setVideoSize(s),
              ),
            ),
            IconButton(
              onPressed: () => context.overviewCubit
                  .setVideoSize(state.videoSize + sizeSteps),
              icon: Icon(context.icons.screen, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoLegend() {
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
