// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_application_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TestApplicationState {
  TestApplication get application => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  String? get iconPath => throw _privateConstructorUsedError;
  String get fileDirectory => throw _privateConstructorUsedError;
  List<TestScenario> get scenarios => throw _privateConstructorUsedError;

  /// Create a copy of TestApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TestApplicationStateCopyWith<TestApplicationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestApplicationStateCopyWith<$Res> {
  factory $TestApplicationStateCopyWith(TestApplicationState value,
          $Res Function(TestApplicationState) then) =
      _$TestApplicationStateCopyWithImpl<$Res, TestApplicationState>;
  @useResult
  $Res call(
      {TestApplication application,
      String name,
      String id,
      String? iconPath,
      String fileDirectory,
      List<TestScenario> scenarios});
}

/// @nodoc
class _$TestApplicationStateCopyWithImpl<$Res,
        $Val extends TestApplicationState>
    implements $TestApplicationStateCopyWith<$Res> {
  _$TestApplicationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TestApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? application = null,
    Object? name = null,
    Object? id = null,
    Object? iconPath = freezed,
    Object? fileDirectory = null,
    Object? scenarios = null,
  }) {
    return _then(_value.copyWith(
      application: null == application
          ? _value.application
          : application // ignore: cast_nullable_to_non_nullable
              as TestApplication,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      iconPath: freezed == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String?,
      fileDirectory: null == fileDirectory
          ? _value.fileDirectory
          : fileDirectory // ignore: cast_nullable_to_non_nullable
              as String,
      scenarios: null == scenarios
          ? _value.scenarios
          : scenarios // ignore: cast_nullable_to_non_nullable
              as List<TestScenario>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TestApplicationStateImplCopyWith<$Res>
    implements $TestApplicationStateCopyWith<$Res> {
  factory _$$TestApplicationStateImplCopyWith(_$TestApplicationStateImpl value,
          $Res Function(_$TestApplicationStateImpl) then) =
      __$$TestApplicationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TestApplication application,
      String name,
      String id,
      String? iconPath,
      String fileDirectory,
      List<TestScenario> scenarios});
}

/// @nodoc
class __$$TestApplicationStateImplCopyWithImpl<$Res>
    extends _$TestApplicationStateCopyWithImpl<$Res, _$TestApplicationStateImpl>
    implements _$$TestApplicationStateImplCopyWith<$Res> {
  __$$TestApplicationStateImplCopyWithImpl(_$TestApplicationStateImpl _value,
      $Res Function(_$TestApplicationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TestApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? application = null,
    Object? name = null,
    Object? id = null,
    Object? iconPath = freezed,
    Object? fileDirectory = null,
    Object? scenarios = null,
  }) {
    return _then(_$TestApplicationStateImpl(
      application: null == application
          ? _value.application
          : application // ignore: cast_nullable_to_non_nullable
              as TestApplication,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      iconPath: freezed == iconPath
          ? _value.iconPath
          : iconPath // ignore: cast_nullable_to_non_nullable
              as String?,
      fileDirectory: null == fileDirectory
          ? _value.fileDirectory
          : fileDirectory // ignore: cast_nullable_to_non_nullable
              as String,
      scenarios: null == scenarios
          ? _value._scenarios
          : scenarios // ignore: cast_nullable_to_non_nullable
              as List<TestScenario>,
    ));
  }
}

/// @nodoc

class _$TestApplicationStateImpl extends _TestApplicationState {
  const _$TestApplicationStateImpl(
      {required this.application,
      required this.name,
      required this.id,
      this.iconPath,
      required this.fileDirectory,
      required final List<TestScenario> scenarios})
      : _scenarios = scenarios,
        super._();

  @override
  final TestApplication application;
  @override
  final String name;
  @override
  final String id;
  @override
  final String? iconPath;
  @override
  final String fileDirectory;
  final List<TestScenario> _scenarios;
  @override
  List<TestScenario> get scenarios {
    if (_scenarios is EqualUnmodifiableListView) return _scenarios;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_scenarios);
  }

  @override
  String toString() {
    return 'TestApplicationState(application: $application, name: $name, id: $id, iconPath: $iconPath, fileDirectory: $fileDirectory, scenarios: $scenarios)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TestApplicationStateImpl &&
            (identical(other.application, application) ||
                other.application == application) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath) &&
            (identical(other.fileDirectory, fileDirectory) ||
                other.fileDirectory == fileDirectory) &&
            const DeepCollectionEquality()
                .equals(other._scenarios, _scenarios));
  }

  @override
  int get hashCode => Object.hash(runtimeType, application, name, id, iconPath,
      fileDirectory, const DeepCollectionEquality().hash(_scenarios));

  /// Create a copy of TestApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TestApplicationStateImplCopyWith<_$TestApplicationStateImpl>
      get copyWith =>
          __$$TestApplicationStateImplCopyWithImpl<_$TestApplicationStateImpl>(
              this, _$identity);
}

abstract class _TestApplicationState extends TestApplicationState {
  const factory _TestApplicationState(
          {required final TestApplication application,
          required final String name,
          required final String id,
          final String? iconPath,
          required final String fileDirectory,
          required final List<TestScenario> scenarios}) =
      _$TestApplicationStateImpl;
  const _TestApplicationState._() : super._();

  @override
  TestApplication get application;
  @override
  String get name;
  @override
  String get id;
  @override
  String? get iconPath;
  @override
  String get fileDirectory;
  @override
  List<TestScenario> get scenarios;

  /// Create a copy of TestApplicationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TestApplicationStateImplCopyWith<_$TestApplicationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
