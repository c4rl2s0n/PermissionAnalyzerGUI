import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/screen_record_overview/logic/logic.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/screen_record_overview/widgets/timeline_selection_dialog.dart';
import 'package:video_player/video_player.dart';

class TestRunLiveView extends StatefulWidget {
  const TestRunLiveView(
    this.test, {
    this.size,
    this.onDurationUpdate,
    this.initialPosition,
    this.initialPlaybackSpeed,
    this.initialIsPlaying = false,
    this.playPauseStream,
    this.resetStream,
    this.playbackSpeedStream,
    this.seekToStream,
    super.key,
  });
  final TestRun test;
  final Size? size;
  final Function(Duration)? onDurationUpdate;
  final Duration? initialPosition;
  final double? initialPlaybackSpeed;
  final bool initialIsPlaying;
  final Stream<bool>? playPauseStream;
  final Stream<void>? resetStream;
  final Stream<double>? playbackSpeedStream;
  final Stream<Duration>? seekToStream;
  @override
  TestRunLiveViewState createState() => TestRunLiveViewState();
}

class TestRunLiveViewState extends State<TestRunLiveView> {
  VideoPlayerController? _controller;
  TestRun get test => widget.test;

  List<StreamSubscription?> listener = [];

  bool isPlaying = false;
  double lastSecond = 0;

  @override
  void initState() {
    super.initState();
    // load the recording-file
    if (test.screenRecordPath.empty) return;
    var file = File(test.screenRecordPath!);
    if (!file.existsSync()) return;
    _controller = VideoPlayerController.file(file);
    if (widget.onDurationUpdate != null) {
      _controller?.addListener(() async {
        if (_controller?.value.hasError ?? false) {
          Logger.root.warning(
              "[${test.name}] Video Player Error: ${_controller?.value.errorDescription}");
        }
        Duration? position = await _controller?.position;
        if (position != null) {
          double newPosition = position.inMilliseconds / 1000;
          if (newPosition > lastSecond + 1) {
            Logger.root.finer(
                "[${test.name}] Playback Jump: Last $lastSecond -> Now ${position.inMilliseconds / 1000}");
          } else {
            widget.onDurationUpdate!(position);
            lastSecond = newPosition;
          }
        }
      });
    }
    _controller?.setLooping(false);
    _controller?.initialize().then((_) => _onControllerInitialized());
  }
  Future _onControllerInitialized()async{
    if(widget.initialPosition != null){
      await _seekTo(widget.initialPosition!);
    }
    if(widget.initialPlaybackSpeed != null){
      await _controller?.setPlaybackSpeed(widget.initialPlaybackSpeed!);
    }
    if(widget.initialIsPlaying){
      await _play();
    }
    _setupControlsListener();
  }
  void _setupControlsListener() {
    // Restart
    listener.add(widget.resetStream?.listen((_) async {
      await _pause();
      await _seekTo(Duration.zero);
    }));
    // Play/Pause
    listener.add(widget.playPauseStream?.listen((play) async {
      if (play && _controller != null && !_controller!.value.isCompleted) {
        await _play();
      } else {
        await _pause();
      }
    }));
    // Playback Speed
    listener.add(widget.playbackSpeedStream?.listen((speed) async {
      await _controller?.setPlaybackSpeed(speed);
    }));
    // SeekTo
    listener.add(widget.seekToStream?.listen((pos) async {
      await _seekTo(pos);
    }));

    setState(() {});
  }

  Future _seekTo(Duration pos) async {
    if (_controller == null) return;
    lastSecond = pos.inMilliseconds / 1000;
    await _controller!.seekTo(pos);
    if (!_controller!.value.isPlaying && isPlaying) {
      await _controller!.play();
    }
    setState(() {});
  }

  Future _play() async {
    await _controller?.play();
    setState(() {
      isPlaying = true;
    });
  }

  Future _pause() async {
    await _controller?.pause();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    for (var l in listener) {
      l?.cancel();
    }
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size?.width,
      height: widget.size?.height,
      child: InfoContainer(
        title: test.name,
        headerTextStyle: context.textTheme.labelSmall,
        headerHeight: 40,
        action: _containerActionView(context),
        child: _video(),
      ),
    );
  }

  Widget _containerActionView(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        _selectedTimelinesContainerIndication(),
        _monitorSelection(context),
      ],
    );
  }

  Widget _selectedTimelinesContainerIndication() {
    return BlocBuilder<ScreenRecorderOverviewCubit,
        ScreenRecorderOverviewState>(
      buildWhen: (oldState, state) =>
          oldState.timelines != state.timelines &&
          oldState.selectedTimelines != state.selectedTimelines,
      builder: (context, overviewState) {
        List<TimelineState> timelines = overviewState.timelinesForTest(test, selectedOnly: true);
        List<Color> selectedColors = timelines.map((t) => t.color).nonNulls.toList();
        return Tooltip(
        richMessage: WidgetSpan(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...timelines.map(
                    (t) => Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          context.icons.mapMarker,
                          color: t.color,
                          size: 18,
                        ),
                        Margin.horizontal(context.constants.spacing),
                        Text(t.name),
                      ],
                    ),
                  ),
            ],
          ),
        ),
        child: Icon(
          context.icons.mapMarker,
          color: selectedColors.length == 1 ? selectedColors.first : null,
          size: 18,
        ),
      );}
    );
  }

  Widget _video() {
    if (_controller == null) return const Text("Screen Record not found...");
    double aspectRatio = _controller!.value.aspectRatio;
    Size? size;
    if (widget.size != null) {
      size = Size(
          widget.size!.width * aspectRatio, widget.size!.height / aspectRatio);
    }
    return Optional(
      buildOptional: (child) => SizedBox.fromSize(
        size: size,
        child: child,
      ),
      useOptional: size != null,
      child: Center(
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              VideoPlayer(_controller!),
              //_ControlsOverlay(controller: _controller),
              VideoProgressIndicator(_controller!, allowScrubbing: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _monitorSelection(BuildContext context) {
    return IconButton(
      icon: Icon(context.icons.test),
      onPressed: () async {
        await TimelineSelectionDialog.showTimelineSelection(
          context,
          test,
          context.overviewCubit,
        );
      },
    );
  }
}
