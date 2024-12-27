// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analysis_traffic_group_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AnalysisTrafficGroupState {
  TrafficGroup get group => throw _privateConstructorUsedError;
  AnalysisTrafficGroupCubit? get parent => throw _privateConstructorUsedError;
  List<AnalysisTrafficGroupCubit> get children =>
      throw _privateConstructorUsedError;
  SelectionState get selected => throw _privateConstructorUsedError;
  bool get show => throw _privateConstructorUsedError;

  /// Create a copy of AnalysisTrafficGroupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AnalysisTrafficGroupStateCopyWith<AnalysisTrafficGroupState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AnalysisTrafficGroupStateCopyWith<$Res> {
  factory $AnalysisTrafficGroupStateCopyWith(AnalysisTrafficGroupState value,
          $Res Function(AnalysisTrafficGroupState) then) =
      _$AnalysisTrafficGroupStateCopyWithImpl<$Res, AnalysisTrafficGroupState>;
  @useResult
  $Res call(
      {TrafficGroup group,
      AnalysisTrafficGroupCubit? parent,
      List<AnalysisTrafficGroupCubit> children,
      SelectionState selected,
      bool show});
}

/// @nodoc
class _$AnalysisTrafficGroupStateCopyWithImpl<$Res,
        $Val extends AnalysisTrafficGroupState>
    implements $AnalysisTrafficGroupStateCopyWith<$Res> {
  _$AnalysisTrafficGroupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AnalysisTrafficGroupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = null,
    Object? parent = freezed,
    Object? children = null,
    Object? selected = null,
    Object? show = null,
  }) {
    return _then(_value.copyWith(
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as TrafficGroup,
      parent: freezed == parent
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as AnalysisTrafficGroupCubit?,
      children: null == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<AnalysisTrafficGroupCubit>,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as SelectionState,
      show: null == show
          ? _value.show
          : show // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AnalysisTrafficGroupStateImplCopyWith<$Res>
    implements $AnalysisTrafficGroupStateCopyWith<$Res> {
  factory _$$AnalysisTrafficGroupStateImplCopyWith(
          _$AnalysisTrafficGroupStateImpl value,
          $Res Function(_$AnalysisTrafficGroupStateImpl) then) =
      __$$AnalysisTrafficGroupStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TrafficGroup group,
      AnalysisTrafficGroupCubit? parent,
      List<AnalysisTrafficGroupCubit> children,
      SelectionState selected,
      bool show});
}

/// @nodoc
class __$$AnalysisTrafficGroupStateImplCopyWithImpl<$Res>
    extends _$AnalysisTrafficGroupStateCopyWithImpl<$Res,
        _$AnalysisTrafficGroupStateImpl>
    implements _$$AnalysisTrafficGroupStateImplCopyWith<$Res> {
  __$$AnalysisTrafficGroupStateImplCopyWithImpl(
      _$AnalysisTrafficGroupStateImpl _value,
      $Res Function(_$AnalysisTrafficGroupStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of AnalysisTrafficGroupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? group = null,
    Object? parent = freezed,
    Object? children = null,
    Object? selected = null,
    Object? show = null,
  }) {
    return _then(_$AnalysisTrafficGroupStateImpl(
      group: null == group
          ? _value.group
          : group // ignore: cast_nullable_to_non_nullable
              as TrafficGroup,
      parent: freezed == parent
          ? _value.parent
          : parent // ignore: cast_nullable_to_non_nullable
              as AnalysisTrafficGroupCubit?,
      children: null == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<AnalysisTrafficGroupCubit>,
      selected: null == selected
          ? _value.selected
          : selected // ignore: cast_nullable_to_non_nullable
              as SelectionState,
      show: null == show
          ? _value.show
          : show // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AnalysisTrafficGroupStateImpl extends _AnalysisTrafficGroupState {
  const _$AnalysisTrafficGroupStateImpl(
      {required this.group,
      this.parent,
      required final List<AnalysisTrafficGroupCubit> children,
      required this.selected,
      required this.show})
      : _children = children,
        super._();

  @override
  final TrafficGroup group;
  @override
  final AnalysisTrafficGroupCubit? parent;
  final List<AnalysisTrafficGroupCubit> _children;
  @override
  List<AnalysisTrafficGroupCubit> get children {
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_children);
  }

  @override
  final SelectionState selected;
  @override
  final bool show;

  @override
  String toString() {
    return 'AnalysisTrafficGroupState(group: $group, parent: $parent, children: $children, selected: $selected, show: $show)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AnalysisTrafficGroupStateImpl &&
            (identical(other.group, group) || other.group == group) &&
            (identical(other.parent, parent) || other.parent == parent) &&
            const DeepCollectionEquality().equals(other._children, _children) &&
            (identical(other.selected, selected) ||
                other.selected == selected) &&
            (identical(other.show, show) || other.show == show));
  }

  @override
  int get hashCode => Object.hash(runtimeType, group, parent,
      const DeepCollectionEquality().hash(_children), selected, show);

  /// Create a copy of AnalysisTrafficGroupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AnalysisTrafficGroupStateImplCopyWith<_$AnalysisTrafficGroupStateImpl>
      get copyWith => __$$AnalysisTrafficGroupStateImplCopyWithImpl<
          _$AnalysisTrafficGroupStateImpl>(this, _$identity);
}

abstract class _AnalysisTrafficGroupState extends AnalysisTrafficGroupState {
  const factory _AnalysisTrafficGroupState(
      {required final TrafficGroup group,
      final AnalysisTrafficGroupCubit? parent,
      required final List<AnalysisTrafficGroupCubit> children,
      required final SelectionState selected,
      required final bool show}) = _$AnalysisTrafficGroupStateImpl;
  const _AnalysisTrafficGroupState._() : super._();

  @override
  TrafficGroup get group;
  @override
  AnalysisTrafficGroupCubit? get parent;
  @override
  List<AnalysisTrafficGroupCubit> get children;
  @override
  SelectionState get selected;
  @override
  bool get show;

  /// Create a copy of AnalysisTrafficGroupState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AnalysisTrafficGroupStateImplCopyWith<_$AnalysisTrafficGroupStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
