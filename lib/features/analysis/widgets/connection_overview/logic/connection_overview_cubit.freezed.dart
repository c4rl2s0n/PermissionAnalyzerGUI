// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'connection_overview_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ConnectionOverviewState {
  List<INetworkConnection> get connections =>
      throw _privateConstructorUsedError;
  List<NetworkPacket> get packets => throw _privateConstructorUsedError;
  int? get selectedIndex => throw _privateConstructorUsedError;

  /// Create a copy of ConnectionOverviewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConnectionOverviewStateCopyWith<ConnectionOverviewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionOverviewStateCopyWith<$Res> {
  factory $ConnectionOverviewStateCopyWith(ConnectionOverviewState value,
          $Res Function(ConnectionOverviewState) then) =
      _$ConnectionOverviewStateCopyWithImpl<$Res, ConnectionOverviewState>;
  @useResult
  $Res call(
      {List<INetworkConnection> connections,
      List<NetworkPacket> packets,
      int? selectedIndex});
}

/// @nodoc
class _$ConnectionOverviewStateCopyWithImpl<$Res,
        $Val extends ConnectionOverviewState>
    implements $ConnectionOverviewStateCopyWith<$Res> {
  _$ConnectionOverviewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConnectionOverviewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connections = null,
    Object? packets = null,
    Object? selectedIndex = freezed,
  }) {
    return _then(_value.copyWith(
      connections: null == connections
          ? _value.connections
          : connections // ignore: cast_nullable_to_non_nullable
              as List<INetworkConnection>,
      packets: null == packets
          ? _value.packets
          : packets // ignore: cast_nullable_to_non_nullable
              as List<NetworkPacket>,
      selectedIndex: freezed == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConnectionOverviewStateImplCopyWith<$Res>
    implements $ConnectionOverviewStateCopyWith<$Res> {
  factory _$$ConnectionOverviewStateImplCopyWith(
          _$ConnectionOverviewStateImpl value,
          $Res Function(_$ConnectionOverviewStateImpl) then) =
      __$$ConnectionOverviewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<INetworkConnection> connections,
      List<NetworkPacket> packets,
      int? selectedIndex});
}

/// @nodoc
class __$$ConnectionOverviewStateImplCopyWithImpl<$Res>
    extends _$ConnectionOverviewStateCopyWithImpl<$Res,
        _$ConnectionOverviewStateImpl>
    implements _$$ConnectionOverviewStateImplCopyWith<$Res> {
  __$$ConnectionOverviewStateImplCopyWithImpl(
      _$ConnectionOverviewStateImpl _value,
      $Res Function(_$ConnectionOverviewStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ConnectionOverviewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connections = null,
    Object? packets = null,
    Object? selectedIndex = freezed,
  }) {
    return _then(_$ConnectionOverviewStateImpl(
      connections: null == connections
          ? _value._connections
          : connections // ignore: cast_nullable_to_non_nullable
              as List<INetworkConnection>,
      packets: null == packets
          ? _value._packets
          : packets // ignore: cast_nullable_to_non_nullable
              as List<NetworkPacket>,
      selectedIndex: freezed == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$ConnectionOverviewStateImpl extends _ConnectionOverviewState {
  const _$ConnectionOverviewStateImpl(
      {required final List<INetworkConnection> connections,
      required final List<NetworkPacket> packets,
      this.selectedIndex})
      : _connections = connections,
        _packets = packets,
        super._();

  final List<INetworkConnection> _connections;
  @override
  List<INetworkConnection> get connections {
    if (_connections is EqualUnmodifiableListView) return _connections;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_connections);
  }

  final List<NetworkPacket> _packets;
  @override
  List<NetworkPacket> get packets {
    if (_packets is EqualUnmodifiableListView) return _packets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_packets);
  }

  @override
  final int? selectedIndex;

  @override
  String toString() {
    return 'ConnectionOverviewState(connections: $connections, packets: $packets, selectedIndex: $selectedIndex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConnectionOverviewStateImpl &&
            const DeepCollectionEquality()
                .equals(other._connections, _connections) &&
            const DeepCollectionEquality().equals(other._packets, _packets) &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_connections),
      const DeepCollectionEquality().hash(_packets),
      selectedIndex);

  /// Create a copy of ConnectionOverviewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConnectionOverviewStateImplCopyWith<_$ConnectionOverviewStateImpl>
      get copyWith => __$$ConnectionOverviewStateImplCopyWithImpl<
          _$ConnectionOverviewStateImpl>(this, _$identity);
}

abstract class _ConnectionOverviewState extends ConnectionOverviewState {
  const factory _ConnectionOverviewState(
      {required final List<INetworkConnection> connections,
      required final List<NetworkPacket> packets,
      final int? selectedIndex}) = _$ConnectionOverviewStateImpl;
  const _ConnectionOverviewState._() : super._();

  @override
  List<INetworkConnection> get connections;
  @override
  List<NetworkPacket> get packets;
  @override
  int? get selectedIndex;

  /// Create a copy of ConnectionOverviewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConnectionOverviewStateImplCopyWith<_$ConnectionOverviewStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
