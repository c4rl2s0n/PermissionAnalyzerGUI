import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'analysis_traffic_group_cubit.freezed.dart';

enum SelectionState {
  deselected,
  selected,
  custom;

  SelectionState get next => this == SelectionState.deselected
      ? SelectionState.selected
      : SelectionState.deselected;
}

class AnalysisTrafficGroupCubit extends Cubit<AnalysisTrafficGroupState> {
  AnalysisTrafficGroupCubit({
    required this.group,
    SelectionState selected = SelectionState.selected,
    List<AnalysisTrafficGroupCubit> children = const [],
    bool show = true,
  }) : super(AnalysisTrafficGroupState(
          group: group,
          selected: selected,
          children: children,
          show: show,
        )) {
    initializeParents();
  }

  TrafficGroup group;
  String get name => state.group.name;
  String? get info => state.group.info;
  List<String> get tags => state.group.tags;
  int get testRuns => state.group.testRuns;
  AnalysisTrafficGroupCubit? get parent => state.parent;
  List<AnalysisTrafficGroupCubit> get children => state.children;
  int get endpointCountMin => state.group.endpointCountMin;
  int get endpointCountMax => state.group.endpointCountMax;
  int get endpointCountAvg => state.group.endpointCountAvg;

  void loadEndpoints(){

  }
  void initializeParents() {
    for (var child in state.children) {
      child.setParent(this);
    }
  }

  void setParent(AnalysisTrafficGroupCubit parent) {
    group.id = state.id;
    emit(state.copyWith(group: group, parent: parent));
  }

  // manage selection state
  void setSelected(SelectionState selected) {
    for (var child in state.children) {
      child.setSelected(selected);
    }
    emit(state.copyWith(selected: selected));
  }

  void toggleSelected() {
    SelectionState selected = state.selected.next;
    setSelected(selected);
    state.parent?.updateSelectedFromChildren();
  }

  void updateSelectedFromChildren() {
    if (state.selected == SelectionState.selected &&
        state.children
            .any((c) => c.state.selected != SelectionState.selected)) {
      emit(state.copyWith(selected: SelectionState.custom));
    } else if (state.selected == SelectionState.deselected &&
        state.children
            .any((c) => c.state.selected != SelectionState.deselected)) {
      emit(state.copyWith(selected: SelectionState.custom));
    } else if (state.children
        .every((c) => c.state.selected == SelectionState.selected)) {
      emit(state.copyWith(selected: SelectionState.selected));
    } else if (state.children
        .every((c) => c.state.selected == SelectionState.deselected)) {
      emit(state.copyWith(selected: SelectionState.deselected));
    }
    state.parent?.updateSelectedFromChildren();
  }

  // show group in analysis
  void toggleShow() {
    emit(state.copyWith(show: !state.show));
  }
  void setShowChildren(bool show){
    for(var child in state.children){
      child.setShowChildren(show);
    }
    emit(state.copyWith(show: show));
  }
  void toggleShowChildren() {
    bool show = !state.show;
    for(var child in state.children){
      child.setShowChildren(show);
    }
    emit(state.copyWith(show: show));
  }

  void updateGroupFromChildren() {
    if (state.children.isEmpty) return;
    List<AnalysisTrafficGroupCubit> children =
        state.children.where((c) => c.state.isSelected).toList();
    List<TestRun> tests = children.fold([], (all, child) => [...all, ...child.group.tests]);

    group = TrafficGroup(
      name: state.group.name,
      info: state.group.info,
      id: state.group.id,
      tags: state.group.tags,
      data: state.group.data,
      tests: tests,
    );
    emit(state.copyWith(group: group));
  }
}

@freezed
class AnalysisTrafficGroupState with _$AnalysisTrafficGroupState {
  const AnalysisTrafficGroupState._();

  const factory AnalysisTrafficGroupState({
    required TrafficGroup group,
    AnalysisTrafficGroupCubit? parent,
    required List<AnalysisTrafficGroupCubit> children,
    required SelectionState selected,
    required bool show,
  }) = _AnalysisTrafficGroupState;

  String get id =>
      "${parent?.name != null ? "${parent!.name}_" : ""}${group.name}";
  bool get isSelected => selected != SelectionState.deselected;
}
