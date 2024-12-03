// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_run_analysis_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TestRunAnalysisState {
  List<TestRunDto> get tests => throw _privateConstructorUsedError;
  int? get selectedTestIndex => throw _privateConstructorUsedError;
  int? get selectedPacketIndex => throw _privateConstructorUsedError;
  TrafficConnection? get selectedConnection =>
      throw _privateConstructorUsedError;

  /// Create a copy of TestRunAnalysisState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestRunAnalysisStateCopyWith<TestRunAnalysisState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestRunAnalysisStateCopyWith<$Res> {
  factory $TestRunAnalysisStateCopyWith(TestRunAnalysisState value,
          $Res Function(TestRunAnalysisState) then) =
      _$TestRunAnalysisStateCopyWithImpl<$Res, TestRunAnalysisState>;
  @useResult
  $Res call(
      {List<TestRunDto> tests,
      int? selectedTestIndex,
      int? selectedPacketIndex,
      TrafficConnection? selectedConnection});
}

/// @nodoc
class _$TestRunAnalysisStateCopyWithImpl<$Res,
        $Val extends TestRunAnalysisState>
    implements $TestRunAnalysisStateCopyWith<$Res> {
  _$TestRunAnalysisStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestRunAnalysisState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tests = null,
    Object? selectedTestIndex = freezed,
    Object? selectedPacketIndex = freezed,
    Object? selectedConnection = freezed,
  }) {
    return _then(_value.copyWith(
      tests: null == tests
          ? _value.tests
          : tests // ignore: cast_nullable_to_non_nullable
              as List<TestRunDto>,
      selectedTestIndex: freezed == selectedTestIndex
          ? _value.selectedTestIndex
          : selectedTestIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      selectedPacketIndex: freezed == selectedPacketIndex
          ? _value.selectedPacketIndex
          : selectedPacketIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      selectedConnection: freezed == selectedConnection
          ? _value.selectedConnection
          : selectedConnection // ignore: cast_nullable_to_non_nullable
              as TrafficConnection?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TestRunAnalysisStateImplCopyWith<$Res>
    implements $TestRunAnalysisStateCopyWith<$Res> {
  factory _$$TestRunAnalysisStateImplCopyWith(_$TestRunAnalysisStateImpl value,
          $Res Function(_$TestRunAnalysisStateImpl) then) =
      __$$TestRunAnalysisStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<TestRunDto> tests,
      int? selectedTestIndex,
      int? selectedPacketIndex,
      TrafficConnection? selectedConnection});
}

/// @nodoc
class __$$TestRunAnalysisStateImplCopyWithImpl<$Res>
    extends _$TestRunAnalysisStateCopyWithImpl<$Res, _$TestRunAnalysisStateImpl>
    implements _$$TestRunAnalysisStateImplCopyWith<$Res> {
  __$$TestRunAnalysisStateImplCopyWithImpl(_$TestRunAnalysisStateImpl _value,
      $Res Function(_$TestRunAnalysisStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TestRunAnalysisState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? tests = null,
    Object? selectedTestIndex = freezed,
    Object? selectedPacketIndex = freezed,
    Object? selectedConnection = freezed,
  }) {
    return _then(_$TestRunAnalysisStateImpl(
      tests: null == tests
          ? _value._tests
          : tests // ignore: cast_nullable_to_non_nullable
              as List<TestRunDto>,
      selectedTestIndex: freezed == selectedTestIndex
          ? _value.selectedTestIndex
          : selectedTestIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      selectedPacketIndex: freezed == selectedPacketIndex
          ? _value.selectedPacketIndex
          : selectedPacketIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      selectedConnection: freezed == selectedConnection
          ? _value.selectedConnection
          : selectedConnection // ignore: cast_nullable_to_non_nullable
              as TrafficConnection?,
    ));
  }
}

/// @nodoc

class _$TestRunAnalysisStateImpl extends _TestRunAnalysisState {
  const _$TestRunAnalysisStateImpl(
      {required final List<TestRunDto> tests,
      this.selectedTestIndex,
      this.selectedPacketIndex,
      this.selectedConnection})
      : _tests = tests,
        super._();

  final List<TestRunDto> _tests;
  @override
  List<TestRunDto> get tests {
    if (_tests is EqualUnmodifiableListView) return _tests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tests);
  }

  @override
  final int? selectedTestIndex;
  @override
  final int? selectedPacketIndex;
  @override
  final TrafficConnection? selectedConnection;

  @override
  String toString() {
    return 'TestRunAnalysisState(tests: $tests, selectedTestIndex: $selectedTestIndex, selectedPacketIndex: $selectedPacketIndex, selectedConnection: $selectedConnection)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestRunAnalysisStateImpl &&
            const DeepCollectionEquality().equals(other._tests, _tests) &&
            (identical(other.selectedTestIndex, selectedTestIndex) ||
                other.selectedTestIndex == selectedTestIndex) &&
            (identical(other.selectedPacketIndex, selectedPacketIndex) ||
                other.selectedPacketIndex == selectedPacketIndex) &&
            (identical(other.selectedConnection, selectedConnection) ||
                other.selectedConnection == selectedConnection));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_tests),
      selectedTestIndex,
      selectedPacketIndex,
      selectedConnection);

  /// Create a copy of TestRunAnalysisState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestRunAnalysisStateImplCopyWith<_$TestRunAnalysisStateImpl>
      get copyWith =>
          __$$TestRunAnalysisStateImplCopyWithImpl<_$TestRunAnalysisStateImpl>(
              this, _$identity);
}

abstract class _TestRunAnalysisState extends TestRunAnalysisState {
  const factory _TestRunAnalysisState(
          {required final List<TestRunDto> tests,
          final int? selectedTestIndex,
          final int? selectedPacketIndex,
          final TrafficConnection? selectedConnection}) =
      _$TestRunAnalysisStateImpl;
  const _TestRunAnalysisState._() : super._();

  @override
  List<TestRunDto> get tests;
  @override
  int? get selectedTestIndex;
  @override
  int? get selectedPacketIndex;
  @override
  TrafficConnection? get selectedConnection;

  /// Create a copy of TestRunAnalysisState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestRunAnalysisStateImplCopyWith<_$TestRunAnalysisStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
