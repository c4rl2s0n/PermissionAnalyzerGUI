import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/models/models.dart';

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
    required this.endpointRepository,
    SelectionState selected = SelectionState.selected,
    List<AnalysisTrafficGroupCubit> children = const [],
    bool show = false,
  }) : super(AnalysisTrafficGroupState(
          group: group,
          selected: selected,
          children: children,
          show: show,
        )) {
    initializeParents();
  }

  // TODO: Add event handling for toggleShow; showing only entries on the same level (and within same 'subtree' in case node is not root)
  // TODO: aggregate endpoints and connections! store by second (mabye just store the graphIds or sth to reduce memory usage)

  INetworkEndpointRepository endpointRepository;

  TrafficGroup group;
  String get name => state.group.name;
  String get fullName => "${path.isNotEmpty ? "$path." : ""}${state.group.name}";
  String? get info => state.group.info;
  List<String> get tags => state.group.graphTags;
  int get testRuns => state.group.testRuns;
  AnalysisTrafficGroupCubit? get parent => state.parent;
  String get path => "${parent?.path ?? ""}${parent != null && parent!.path.isNotEmpty ? "." : ""}${parent?.name ?? ""}";
  List<AnalysisTrafficGroupCubit> get children => state.children;
  int get endpointCountMin => state.group.endpointCountMin;
  int get endpointCountMax => state.group.endpointCountMax;
  int get endpointCountAvg => state.group.endpointCountAvg;

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
    bool show = selected == SelectionState.deselected ? false : state.show;
    emit(state.copyWith(selected: selected, show: show));
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
    setShow(!state.show);
  }
  void setShow(bool show){
    emit(state.copyWith(show: show));
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

  void updateGroupFromChildren({bool connectionsGrouped = false, bool reloadEndpoints = false,}) {
    if (state.children.isEmpty) return;
    List<AnalysisTrafficGroupCubit> children =
        state.children.where((c) => c.state.isSelected).toList();
    for(var child in children){
      child.updateGroupFromChildren(connectionsGrouped: connectionsGrouped, reloadEndpoints: reloadEndpoints,);
    }
    List<TestRun> tests = children.fold([], (all, child) => [...all, ...child.group.tests]);

    // reload the endpoints from the database in case they changed
    // if(reloadEndpoints){
    //   for(var test in tests){
    //     for(var connection in test.connections){
    //       connection.endpoint = endpointRepository.getByIp(connection.ip);
    //     }
    //   }
    // }
    group = TrafficGroup(
      name: state.group.name,
      info: state.group.info,
      id: state.group.id,
      graphTags: state.group.graphTags,
      data: state.group.data,
      tests: [],  // set tests separately to ensure grouped is applied correctly
    );
    group.setTests(tests, grouped: connectionsGrouped);
    emit(state.copyWith(group: group));
  }

  void updateGroupConnections({bool grouped=false}) {
    group.loadConnections(grouped: grouped);
    for(var child in children){
      child.updateGroupConnections(grouped: grouped);
    }
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
