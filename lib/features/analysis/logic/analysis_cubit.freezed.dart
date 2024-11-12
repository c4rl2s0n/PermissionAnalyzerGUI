// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analysis_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AnalysisState {
  EndpointAnalysis? get endpointAnalysis => throw _privateConstructorUsedError;

  /// Create a copy of AnalysisState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalysisStateCopyWith<AnalysisState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalysisStateCopyWith<$Res> {
  factory $AnalysisStateCopyWith(
          AnalysisState value, $Res Function(AnalysisState) then) =
      _$AnalysisStateCopyWithImpl<$Res, AnalysisState>;
  @useResult
  $Res call({EndpointAnalysis? endpointAnalysis});
}

/// @nodoc
class _$AnalysisStateCopyWithImpl<$Res, $Val extends AnalysisState>
    implements $AnalysisStateCopyWith<$Res> {
  _$AnalysisStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalysisState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? endpointAnalysis = freezed,
  }) {
    return _then(_value.copyWith(
      endpointAnalysis: freezed == endpointAnalysis
          ? _value.endpointAnalysis
          : endpointAnalysis // ignore: cast_nullable_to_non_nullable
              as EndpointAnalysis?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnalysisStateImplCopyWith<$Res>
    implements $AnalysisStateCopyWith<$Res> {
  factory _$$AnalysisStateImplCopyWith(
          _$AnalysisStateImpl value, $Res Function(_$AnalysisStateImpl) then) =
      __$$AnalysisStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({EndpointAnalysis? endpointAnalysis});
}

/// @nodoc
class __$$AnalysisStateImplCopyWithImpl<$Res>
    extends _$AnalysisStateCopyWithImpl<$Res, _$AnalysisStateImpl>
    implements _$$AnalysisStateImplCopyWith<$Res> {
  __$$AnalysisStateImplCopyWithImpl(
      _$AnalysisStateImpl _value, $Res Function(_$AnalysisStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnalysisState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? endpointAnalysis = freezed,
  }) {
    return _then(_$AnalysisStateImpl(
      endpointAnalysis: freezed == endpointAnalysis
          ? _value.endpointAnalysis
          : endpointAnalysis // ignore: cast_nullable_to_non_nullable
              as EndpointAnalysis?,
    ));
  }
}

/// @nodoc

class _$AnalysisStateImpl implements _AnalysisState {
  const _$AnalysisStateImpl({required this.endpointAnalysis});

  @override
  final EndpointAnalysis? endpointAnalysis;

  @override
  String toString() {
    return 'AnalysisState(endpointAnalysis: $endpointAnalysis)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalysisStateImpl &&
            (identical(other.endpointAnalysis, endpointAnalysis) ||
                other.endpointAnalysis == endpointAnalysis));
  }

  @override
  int get hashCode => Object.hash(runtimeType, endpointAnalysis);

  /// Create a copy of AnalysisState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalysisStateImplCopyWith<_$AnalysisStateImpl> get copyWith =>
      __$$AnalysisStateImplCopyWithImpl<_$AnalysisStateImpl>(this, _$identity);
}

abstract class _AnalysisState implements AnalysisState {
  const factory _AnalysisState(
          {required final EndpointAnalysis? endpointAnalysis}) =
      _$AnalysisStateImpl;

  @override
  EndpointAnalysis? get endpointAnalysis;

  /// Create a copy of AnalysisState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalysisStateImplCopyWith<_$AnalysisStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
