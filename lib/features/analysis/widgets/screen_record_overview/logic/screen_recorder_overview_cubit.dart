import 'dart:async';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/screen_record_overview/logic/logic.dart';

part 'screen_recorder_overview_cubit.freezed.dart';

class ScreenRecorderOverviewCubit extends Cubit<ScreenRecorderOverviewState> {
  ScreenRecorderOverviewCubit(List<TestRun> tests)
      : super(ScreenRecorderOverviewState.empty()) {
    initialize(tests);
  }

  late List<TimelineCubit> timelineCubits;

  // Controls
  final StreamController<bool> _playPauseStreamController = StreamController.broadcast();
  Stream<bool> get playPauseStream => _playPauseStreamController.stream;
  final StreamController<void> _resetStreamController = StreamController.broadcast();
  Stream<void> get resetStream => _resetStreamController.stream;
  final StreamController<double> _playbackSpeedStreamController = StreamController.broadcast();
  Stream<double> get playbackSpeedStream => _playbackSpeedStreamController.stream;
  final StreamController<Duration> _seekToStreamController = StreamController.broadcast();
  Stream<Duration> get seekToStream => _seekToStreamController.stream;

  List<StreamSubscription>? cubitListener;
  void initialize(List<TestRun> tests) {
    timelineCubits =
        testsToTimelines(tests).map((t) => TimelineCubit(t)).toList();
    cubitListener = [];
    for (var cubit in timelineCubits) {
      cubitListener!
          .add(cubit.stream.listen((cubitState) => emit(state.copyWith(
                timelines: timelineCubits.map((c) => c.state).toList(),
              ))));
    }
  }

  @override
  Future close() async {
    for (StreamSubscription listener in cubitListener ?? []) {
      await listener.cancel();
    }
    await _playPauseStreamController.close();
    await _resetStreamController.close();
    await _playbackSpeedStreamController.close();
    await _seekToStreamController.close();

    super.close();
  }

  static List<ConnectionTimeline> testsToTimelines(List<TestRun> tests) {
    List<ConnectionTimeline> timelines = [];
    for (var test in tests) {
      var timeline = test.connectionTimeline;
      for (String key in timeline.keys) {
        timelines.add(ConnectionTimeline(
          fallbackName: key,
          test: test,
          timeline: test.connectionTimeline[key]!,
        ));
      }
    }
    return timelines;
  }

  void setVideoSize(double size) {
    if(size < minVideoSize) {
      size = minVideoSize;
    } else if(size > maxVideoSize) {
      size = maxVideoSize;
    }
    emit(state.copyWith(videoSize: size));
  }
  void setPlaybackSpeed(double speed) {
    if(speed < minPlaybackSpeed) {
      speed = minPlaybackSpeed;
    } else if(speed > maxPlaybackSpeed) {
      speed = maxPlaybackSpeed;
    }
    _playbackSpeedStreamController.add(speed);
    emit(state.copyWith(playbackSpeed: speed));
  }

  void togglePlay() {
    emit(state.copyWith(isPlaying: !state.isPlaying));
    _playPauseStreamController.add(state.isPlaying);
  }
  void resetReplay() {
    emit(state.copyWith(isPlaying: false, position: Duration.zero));
    _resetStreamController.add(null);
  }
  void seekTo(Duration position) {
    _seekToStreamController.add(position);
    emit(state.copyWith(position: position));
  }

  void setPlaybackPosition(Duration position) {
    emit(state.copyWith(position: position));
  }
  void updatePlaybackPosition(Duration position) => state.position < position
      ? setPlaybackPosition(position)
      : null;
}

@freezed
class ScreenRecorderOverviewState with _$ScreenRecorderOverviewState {
  const ScreenRecorderOverviewState._();

  const factory ScreenRecorderOverviewState({
    required List<Color> graphColors,
    required double videoSize,
    required double playbackSpeed,
    required Duration position,
    required bool isPlaying,
    required List<TimelineState> timelines,
  }) = _ScreenRecorderOverviewState;

  factory ScreenRecorderOverviewState.empty() => const ScreenRecorderOverviewState(
        graphColors: ColorPicker.colors,
        videoSize: 350,
        playbackSpeed: 1,
        position: Duration.zero,
        isPlaying: false,
        timelines: [],
      );

  List<TimelineState> get selectedTimelines => timelines.where((t) => t.selected).toList();
  List<TimelineState> timelinesForTest(TestRun test, {bool selectedOnly = false,}) =>
      timelines.where((t) => t.test == test && (!selectedOnly || t.selected)).toList();

  double get positionInSeconds => position.inMilliseconds / 1000;
}
