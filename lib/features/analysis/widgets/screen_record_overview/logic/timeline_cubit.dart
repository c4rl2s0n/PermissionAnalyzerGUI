import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/data/models/connection_timeline.dart';

part 'timeline_cubit.freezed.dart';

class TimelineCubit extends Cubit<TimelineState> {
  TimelineCubit(this.timeline)
      : super(TimelineState.fromTimeline(timeline));

  ConnectionTimeline timeline;
  void toggleSelection() {
    emit(state.copyWith(selected: !state.selected));
  }

  void setColor(Color color) {
    timeline.color = color;
    emit(state.copyWith(color: color));
  }
}

@freezed
class TimelineState with _$TimelineState {
  const TimelineState._();

  const factory TimelineState({
    required bool selected,
    Color? color,
    required String name,
    required TestRun test,
    required List<INetworkConnection?> data,
  }) = _TimelineState;
  factory TimelineState.fromTimeline(ConnectionTimeline timeline) => TimelineState(
        selected: false,
        color: timeline.color,
        name: timeline.name,
        test: timeline.test,
        data: timeline.timeline,
      );
}
