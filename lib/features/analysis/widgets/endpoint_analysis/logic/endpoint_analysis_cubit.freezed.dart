// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'endpoint_analysis_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$EndpointAnalysisState {
  bool get hideCommonEndpoints => throw _privateConstructorUsedError;
  List<TrafficEndpoint> get endpoints => throw _privateConstructorUsedError;
  List<TrafficConnection> get connections => throw _privateConstructorUsedError;
  List<TrafficGroup> get groups => throw _privateConstructorUsedError;

  /// Create a copy of EndpointAnalysisState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $EndpointAnalysisStateCopyWith<EndpointAnalysisState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EndpointAnalysisStateCopyWith<$Res> {
  factory $EndpointAnalysisStateCopyWith(EndpointAnalysisState value,
          $Res Function(EndpointAnalysisState) then) =
      _$EndpointAnalysisStateCopyWithImpl<$Res, EndpointAnalysisState>;
  @useResult
  $Res call(
      {bool hideCommonEndpoints,
      List<TrafficEndpoint> endpoints,
      List<TrafficConnection> connections,
      List<TrafficGroup> groups});
}

/// @nodoc
class _$EndpointAnalysisStateCopyWithImpl<$Res,
        $Val extends EndpointAnalysisState>
    implements $EndpointAnalysisStateCopyWith<$Res> {
  _$EndpointAnalysisStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EndpointAnalysisState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hideCommonEndpoints = null,
    Object? endpoints = null,
    Object? connections = null,
    Object? groups = null,
  }) {
    return _then(_value.copyWith(
      hideCommonEndpoints: null == hideCommonEndpoints
          ? _value.hideCommonEndpoints
          : hideCommonEndpoints // ignore: cast_nullable_to_non_nullable
              as bool,
      endpoints: null == endpoints
          ? _value.endpoints
          : endpoints // ignore: cast_nullable_to_non_nullable
              as List<TrafficEndpoint>,
      connections: null == connections
          ? _value.connections
          : connections // ignore: cast_nullable_to_non_nullable
              as List<TrafficConnection>,
      groups: null == groups
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<TrafficGroup>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EndpointAnalysisStateImplCopyWith<$Res>
    implements $EndpointAnalysisStateCopyWith<$Res> {
  factory _$$EndpointAnalysisStateImplCopyWith(
          _$EndpointAnalysisStateImpl value,
          $Res Function(_$EndpointAnalysisStateImpl) then) =
      __$$EndpointAnalysisStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool hideCommonEndpoints,
      List<TrafficEndpoint> endpoints,
      List<TrafficConnection> connections,
      List<TrafficGroup> groups});
}

/// @nodoc
class __$$EndpointAnalysisStateImplCopyWithImpl<$Res>
    extends _$EndpointAnalysisStateCopyWithImpl<$Res,
        _$EndpointAnalysisStateImpl>
    implements _$$EndpointAnalysisStateImplCopyWith<$Res> {
  __$$EndpointAnalysisStateImplCopyWithImpl(_$EndpointAnalysisStateImpl _value,
      $Res Function(_$EndpointAnalysisStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of EndpointAnalysisState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? hideCommonEndpoints = null,
    Object? endpoints = null,
    Object? connections = null,
    Object? groups = null,
  }) {
    return _then(_$EndpointAnalysisStateImpl(
      hideCommonEndpoints: null == hideCommonEndpoints
          ? _value.hideCommonEndpoints
          : hideCommonEndpoints // ignore: cast_nullable_to_non_nullable
              as bool,
      endpoints: null == endpoints
          ? _value._endpoints
          : endpoints // ignore: cast_nullable_to_non_nullable
              as List<TrafficEndpoint>,
      connections: null == connections
          ? _value._connections
          : connections // ignore: cast_nullable_to_non_nullable
              as List<TrafficConnection>,
      groups: null == groups
          ? _value._groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<TrafficGroup>,
    ));
  }
}

/// @nodoc

class _$EndpointAnalysisStateImpl extends _EndpointAnalysisState {
  const _$EndpointAnalysisStateImpl(
      {required this.hideCommonEndpoints,
      required final List<TrafficEndpoint> endpoints,
      required final List<TrafficConnection> connections,
      required final List<TrafficGroup> groups})
      : _endpoints = endpoints,
        _connections = connections,
        _groups = groups,
        super._();

  @override
  final bool hideCommonEndpoints;
  final List<TrafficEndpoint> _endpoints;
  @override
  List<TrafficEndpoint> get endpoints {
    if (_endpoints is EqualUnmodifiableListView) return _endpoints;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_endpoints);
  }

  final List<TrafficConnection> _connections;
  @override
  List<TrafficConnection> get connections {
    if (_connections is EqualUnmodifiableListView) return _connections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_connections);
  }

  final List<TrafficGroup> _groups;
  @override
  List<TrafficGroup> get groups {
    if (_groups is EqualUnmodifiableListView) return _groups;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groups);
  }

  @override
  String toString() {
    return 'EndpointAnalysisState(hideCommonEndpoints: $hideCommonEndpoints, endpoints: $endpoints, connections: $connections, groups: $groups)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EndpointAnalysisStateImpl &&
            (identical(other.hideCommonEndpoints, hideCommonEndpoints) ||
                other.hideCommonEndpoints == hideCommonEndpoints) &&
            const DeepCollectionEquality()
                .equals(other._endpoints, _endpoints) &&
            const DeepCollectionEquality()
                .equals(other._connections, _connections) &&
            const DeepCollectionEquality().equals(other._groups, _groups));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      hideCommonEndpoints,
      const DeepCollectionEquality().hash(_endpoints),
      const DeepCollectionEquality().hash(_connections),
      const DeepCollectionEquality().hash(_groups));

  /// Create a copy of EndpointAnalysisState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EndpointAnalysisStateImplCopyWith<_$EndpointAnalysisStateImpl>
      get copyWith => __$$EndpointAnalysisStateImplCopyWithImpl<
          _$EndpointAnalysisStateImpl>(this, _$identity);
}

abstract class _EndpointAnalysisState extends EndpointAnalysisState {
  const factory _EndpointAnalysisState(
      {required final bool hideCommonEndpoints,
      required final List<TrafficEndpoint> endpoints,
      required final List<TrafficConnection> connections,
      required final List<TrafficGroup> groups}) = _$EndpointAnalysisStateImpl;
  const _EndpointAnalysisState._() : super._();

  @override
  bool get hideCommonEndpoints;
  @override
  List<TrafficEndpoint> get endpoints;
  @override
  List<TrafficConnection> get connections;
  @override
  List<TrafficGroup> get groups;

  /// Create a copy of EndpointAnalysisState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EndpointAnalysisStateImplCopyWith<_$EndpointAnalysisStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
