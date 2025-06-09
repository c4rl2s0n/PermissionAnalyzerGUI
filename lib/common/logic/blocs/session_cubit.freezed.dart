// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SessionState {
  String get adbDevice => throw _privateConstructorUsedError;
  Map<String, List<String>> get deviceApplications =>
      throw _privateConstructorUsedError;
  List<AndroidInputDevice> get adbDeviceEventInputs =>
      throw _privateConstructorUsedError;
  List<TsharkNetworkInterface> get networkInterfaces =>
      throw _privateConstructorUsedError;
  List<TestApplication> get applications => throw _privateConstructorUsedError;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SessionStateCopyWith<SessionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionStateCopyWith<$Res> {
  factory $SessionStateCopyWith(
          SessionState value, $Res Function(SessionState) then) =
      _$SessionStateCopyWithImpl<$Res, SessionState>;
  @useResult
  $Res call(
      {String adbDevice,
      Map<String, List<String>> deviceApplications,
      List<AndroidInputDevice> adbDeviceEventInputs,
      List<TsharkNetworkInterface> networkInterfaces,
      List<TestApplication> applications});
}

/// @nodoc
class _$SessionStateCopyWithImpl<$Res, $Val extends SessionState>
    implements $SessionStateCopyWith<$Res> {
  _$SessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adbDevice = null,
    Object? deviceApplications = null,
    Object? adbDeviceEventInputs = null,
    Object? networkInterfaces = null,
    Object? applications = null,
  }) {
    return _then(_value.copyWith(
      adbDevice: null == adbDevice
          ? _value.adbDevice
          : adbDevice // ignore: cast_nullable_to_non_nullable
              as String,
      deviceApplications: null == deviceApplications
          ? _value.deviceApplications
          : deviceApplications // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      adbDeviceEventInputs: null == adbDeviceEventInputs
          ? _value.adbDeviceEventInputs
          : adbDeviceEventInputs // ignore: cast_nullable_to_non_nullable
              as List<AndroidInputDevice>,
      networkInterfaces: null == networkInterfaces
          ? _value.networkInterfaces
          : networkInterfaces // ignore: cast_nullable_to_non_nullable
              as List<TsharkNetworkInterface>,
      applications: null == applications
          ? _value.applications
          : applications // ignore: cast_nullable_to_non_nullable
              as List<TestApplication>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SessionStateImplCopyWith<$Res>
    implements $SessionStateCopyWith<$Res> {
  factory _$$SessionStateImplCopyWith(
          _$SessionStateImpl value, $Res Function(_$SessionStateImpl) then) =
      __$$SessionStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String adbDevice,
      Map<String, List<String>> deviceApplications,
      List<AndroidInputDevice> adbDeviceEventInputs,
      List<TsharkNetworkInterface> networkInterfaces,
      List<TestApplication> applications});
}

/// @nodoc
class __$$SessionStateImplCopyWithImpl<$Res>
    extends _$SessionStateCopyWithImpl<$Res, _$SessionStateImpl>
    implements _$$SessionStateImplCopyWith<$Res> {
  __$$SessionStateImplCopyWithImpl(
      _$SessionStateImpl _value, $Res Function(_$SessionStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adbDevice = null,
    Object? deviceApplications = null,
    Object? adbDeviceEventInputs = null,
    Object? networkInterfaces = null,
    Object? applications = null,
  }) {
    return _then(_$SessionStateImpl(
      adbDevice: null == adbDevice
          ? _value.adbDevice
          : adbDevice // ignore: cast_nullable_to_non_nullable
              as String,
      deviceApplications: null == deviceApplications
          ? _value._deviceApplications
          : deviceApplications // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      adbDeviceEventInputs: null == adbDeviceEventInputs
          ? _value._adbDeviceEventInputs
          : adbDeviceEventInputs // ignore: cast_nullable_to_non_nullable
              as List<AndroidInputDevice>,
      networkInterfaces: null == networkInterfaces
          ? _value._networkInterfaces
          : networkInterfaces // ignore: cast_nullable_to_non_nullable
              as List<TsharkNetworkInterface>,
      applications: null == applications
          ? _value._applications
          : applications // ignore: cast_nullable_to_non_nullable
              as List<TestApplication>,
    ));
  }
}

/// @nodoc

class _$SessionStateImpl extends _SessionState {
  const _$SessionStateImpl(
      {required this.adbDevice,
      required final Map<String, List<String>> deviceApplications,
      required final List<AndroidInputDevice> adbDeviceEventInputs,
      required final List<TsharkNetworkInterface> networkInterfaces,
      required final List<TestApplication> applications})
      : _deviceApplications = deviceApplications,
        _adbDeviceEventInputs = adbDeviceEventInputs,
        _networkInterfaces = networkInterfaces,
        _applications = applications,
        super._();

  @override
  final String adbDevice;
  final Map<String, List<String>> _deviceApplications;
  @override
  Map<String, List<String>> get deviceApplications {
    if (_deviceApplications is EqualUnmodifiableMapView)
      return _deviceApplications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_deviceApplications);
  }

  final List<AndroidInputDevice> _adbDeviceEventInputs;
  @override
  List<AndroidInputDevice> get adbDeviceEventInputs {
    if (_adbDeviceEventInputs is EqualUnmodifiableListView)
      return _adbDeviceEventInputs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_adbDeviceEventInputs);
  }

  final List<TsharkNetworkInterface> _networkInterfaces;
  @override
  List<TsharkNetworkInterface> get networkInterfaces {
    if (_networkInterfaces is EqualUnmodifiableListView)
      return _networkInterfaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_networkInterfaces);
  }

  final List<TestApplication> _applications;
  @override
  List<TestApplication> get applications {
    if (_applications is EqualUnmodifiableListView) return _applications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_applications);
  }

  @override
  String toString() {
    return 'SessionState(adbDevice: $adbDevice, deviceApplications: $deviceApplications, adbDeviceEventInputs: $adbDeviceEventInputs, networkInterfaces: $networkInterfaces, applications: $applications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionStateImpl &&
            (identical(other.adbDevice, adbDevice) ||
                other.adbDevice == adbDevice) &&
            const DeepCollectionEquality()
                .equals(other._deviceApplications, _deviceApplications) &&
            const DeepCollectionEquality()
                .equals(other._adbDeviceEventInputs, _adbDeviceEventInputs) &&
            const DeepCollectionEquality()
                .equals(other._networkInterfaces, _networkInterfaces) &&
            const DeepCollectionEquality()
                .equals(other._applications, _applications));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      adbDevice,
      const DeepCollectionEquality().hash(_deviceApplications),
      const DeepCollectionEquality().hash(_adbDeviceEventInputs),
      const DeepCollectionEquality().hash(_networkInterfaces),
      const DeepCollectionEquality().hash(_applications));

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionStateImplCopyWith<_$SessionStateImpl> get copyWith =>
      __$$SessionStateImplCopyWithImpl<_$SessionStateImpl>(this, _$identity);
}

abstract class _SessionState extends SessionState {
  const factory _SessionState(
      {required final String adbDevice,
      required final Map<String, List<String>> deviceApplications,
      required final List<AndroidInputDevice> adbDeviceEventInputs,
      required final List<TsharkNetworkInterface> networkInterfaces,
      required final List<TestApplication> applications}) = _$SessionStateImpl;
  const _SessionState._() : super._();

  @override
  String get adbDevice;
  @override
  Map<String, List<String>> get deviceApplications;
  @override
  List<AndroidInputDevice> get adbDeviceEventInputs;
  @override
  List<TsharkNetworkInterface> get networkInterfaces;
  @override
  List<TestApplication> get applications;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SessionStateImplCopyWith<_$SessionStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
