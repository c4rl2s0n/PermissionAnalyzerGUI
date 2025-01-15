// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'screen_recorder_overview_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ScreenRecorderOverviewState {
  List<Color> get graphColors => throw _privateConstructorUsedError;
  double get videoSize => throw _privateConstructorUsedError;
  double get playbackSpeed => throw _privateConstructorUsedError;
  Duration get position => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;
  List<TimelineState> get timelines => throw _privateConstructorUsedError;

  /// Create a copy of ScreenRecorderOverviewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScreenRecorderOverviewStateCopyWith<ScreenRecorderOverviewState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScreenRecorderOverviewStateCopyWith<$Res> {
  factory $ScreenRecorderOverviewStateCopyWith(
          ScreenRecorderOverviewState value,
          $Res Function(ScreenRecorderOverviewState) then) =
      _$ScreenRecorderOverviewStateCopyWithImpl<$Res,
          ScreenRecorderOverviewState>;
  @useResult
  $Res call(
      {List<Color> graphColors,
      double videoSize,
      double playbackSpeed,
      Duration position,
      bool isPlaying,
      List<TimelineState> timelines});
}

/// @nodoc
class _$ScreenRecorderOverviewStateCopyWithImpl<$Res,
        $Val extends ScreenRecorderOverviewState>
    implements $ScreenRecorderOverviewStateCopyWith<$Res> {
  _$ScreenRecorderOverviewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ScreenRecorderOverviewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? graphColors = null,
    Object? videoSize = null,
    Object? playbackSpeed = null,
    Object? position = null,
    Object? isPlaying = null,
    Object? timelines = null,
  }) {
    return _then(_value.copyWith(
      graphColors: null == graphColors
          ? _value.graphColors
          : graphColors // ignore: cast_nullable_to_non_nullable
              as List<Color>,
      videoSize: null == videoSize
          ? _value.videoSize
          : videoSize // ignore: cast_nullable_to_non_nullable
              as double,
      playbackSpeed: null == playbackSpeed
          ? _value.playbackSpeed
          : playbackSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      timelines: null == timelines
          ? _value.timelines
          : timelines // ignore: cast_nullable_to_non_nullable
              as List<TimelineState>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScreenRecorderOverviewStateImplCopyWith<$Res>
    implements $ScreenRecorderOverviewStateCopyWith<$Res> {
  factory _$$ScreenRecorderOverviewStateImplCopyWith(
          _$ScreenRecorderOverviewStateImpl value,
          $Res Function(_$ScreenRecorderOverviewStateImpl) then) =
      __$$ScreenRecorderOverviewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Color> graphColors,
      double videoSize,
      double playbackSpeed,
      Duration position,
      bool isPlaying,
      List<TimelineState> timelines});
}

/// @nodoc
class __$$ScreenRecorderOverviewStateImplCopyWithImpl<$Res>
    extends _$ScreenRecorderOverviewStateCopyWithImpl<$Res,
        _$ScreenRecorderOverviewStateImpl>
    implements _$$ScreenRecorderOverviewStateImplCopyWith<$Res> {
  __$$ScreenRecorderOverviewStateImplCopyWithImpl(
      _$ScreenRecorderOverviewStateImpl _value,
      $Res Function(_$ScreenRecorderOverviewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ScreenRecorderOverviewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? graphColors = null,
    Object? videoSize = null,
    Object? playbackSpeed = null,
    Object? position = null,
    Object? isPlaying = null,
    Object? timelines = null,
  }) {
    return _then(_$ScreenRecorderOverviewStateImpl(
      graphColors: null == graphColors
          ? _value._graphColors
          : graphColors // ignore: cast_nullable_to_non_nullable
              as List<Color>,
      videoSize: null == videoSize
          ? _value.videoSize
          : videoSize // ignore: cast_nullable_to_non_nullable
              as double,
      playbackSpeed: null == playbackSpeed
          ? _value.playbackSpeed
          : playbackSpeed // ignore: cast_nullable_to_non_nullable
              as double,
      position: null == position
          ? _value.position
          : position // ignore: cast_nullable_to_non_nullable
              as Duration,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      timelines: null == timelines
          ? _value._timelines
          : timelines // ignore: cast_nullable_to_non_nullable
              as List<TimelineState>,
    ));
  }
}

/// @nodoc

class _$ScreenRecorderOverviewStateImpl extends _ScreenRecorderOverviewState {
  const _$ScreenRecorderOverviewStateImpl(
      {required final List<Color> graphColors,
      required this.videoSize,
      required this.playbackSpeed,
      required this.position,
      required this.isPlaying,
      required final List<TimelineState> timelines})
      : _graphColors = graphColors,
        _timelines = timelines,
        super._();

  final List<Color> _graphColors;
  @override
  List<Color> get graphColors {
    if (_graphColors is EqualUnmodifiableListView) return _graphColors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_graphColors);
  }

  @override
  final double videoSize;
  @override
  final double playbackSpeed;
  @override
  final Duration position;
  @override
  final bool isPlaying;
  final List<TimelineState> _timelines;
  @override
  List<TimelineState> get timelines {
    if (_timelines is EqualUnmodifiableListView) return _timelines;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_timelines);
  }

  @override
  String toString() {
    return 'ScreenRecorderOverviewState(graphColors: $graphColors, videoSize: $videoSize, playbackSpeed: $playbackSpeed, position: $position, isPlaying: $isPlaying, timelines: $timelines)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScreenRecorderOverviewStateImpl &&
            const DeepCollectionEquality()
                .equals(other._graphColors, _graphColors) &&
            (identical(other.videoSize, videoSize) ||
                other.videoSize == videoSize) &&
            (identical(other.playbackSpeed, playbackSpeed) ||
                other.playbackSpeed == playbackSpeed) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            const DeepCollectionEquality()
                .equals(other._timelines, _timelines));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_graphColors),
      videoSize,
      playbackSpeed,
      position,
      isPlaying,
      const DeepCollectionEquality().hash(_timelines));

  /// Create a copy of ScreenRecorderOverviewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScreenRecorderOverviewStateImplCopyWith<_$ScreenRecorderOverviewStateImpl>
      get copyWith => __$$ScreenRecorderOverviewStateImplCopyWithImpl<
          _$ScreenRecorderOverviewStateImpl>(this, _$identity);
}

abstract class _ScreenRecorderOverviewState
    extends ScreenRecorderOverviewState {
  const factory _ScreenRecorderOverviewState(
          {required final List<Color> graphColors,
          required final double videoSize,
          required final double playbackSpeed,
          required final Duration position,
          required final bool isPlaying,
          required final List<TimelineState> timelines}) =
      _$ScreenRecorderOverviewStateImpl;
  const _ScreenRecorderOverviewState._() : super._();

  @override
  List<Color> get graphColors;
  @override
  double get videoSize;
  @override
  double get playbackSpeed;
  @override
  Duration get position;
  @override
  bool get isPlaying;
  @override
  List<TimelineState> get timelines;

  /// Create a copy of ScreenRecorderOverviewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScreenRecorderOverviewStateImplCopyWith<_$ScreenRecorderOverviewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
