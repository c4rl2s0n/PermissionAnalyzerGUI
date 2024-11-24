import 'package:flutter/material.dart';

class CustomIcons extends ThemeExtension<CustomIcons> {
  const CustomIcons({
    this.infoPositive = Icons.verified,
    this.infoNegative = Icons.error_outline,
    this.save = Icons.save,
    this.check = Icons.check_circle_outline,
    this.cancel = Icons.cancel_outlined,
    this.editList = Icons.edit_note,
    this.checkboxDeselected = Icons.check_box_outline_blank,
    this.checkboxSelected = Icons.check_box,
    this.checkboxCustom = Icons.indeterminate_check_box,
    this.listItemIndicator = Icons.circle,
    this.add = Icons.add,
    this.remove = Icons.remove_circle_outline,
    this.question = Icons.question_mark,
    this.info = Icons.info_outline,
    this.settings = Icons.settings,
    this.search = Icons.search,
    this.error = Icons.error_outline,
    this.warning = Icons.warning_amber,
    this.pickFile = Icons.file_open_outlined,
    this.pickDirectory = Icons.folder_shared_outlined,
    this.reload = Icons.refresh,
    this.record = Icons.fiber_manual_record,
    this.create = Icons.build,
    this.test = Icons.troubleshoot,
    this.run = Icons.directions_run,
    this.reset = Icons.undo,
    this.toggle = Icons.switch_access_shortcut,
    this.analysis = Icons.monitor_heart_outlined,
    this.graph = Icons.nature_outlined,
    this.graphSelected = Icons.nature,
    this.overview = Icons.featured_play_list_outlined,
    this.overviewSelected = Icons.featured_play_list_rounded,
    this.show = Icons.visibility_outlined,
    this.hide = Icons.visibility_off_outlined,
    this.sortAsc = Icons.arrow_downward,
    this.sortDesc = Icons.arrow_upward,
  });

  final IconData infoPositive;
  final IconData infoNegative;
  final IconData save;
  final IconData check;
  final IconData cancel;
  final IconData editList;
  final IconData checkboxDeselected;
  final IconData checkboxSelected;
  final IconData checkboxCustom;
  final IconData listItemIndicator;
  final IconData add;
  final IconData remove;
  final IconData question;
  final IconData info;
  final IconData settings;
  final IconData search;
  final IconData error;
  final IconData warning;
  final IconData pickFile;
  final IconData pickDirectory;
  final IconData reload;
  final IconData record;
  final IconData create;
  final IconData test;
  final IconData run;
  final IconData reset;
  final IconData toggle;
  final IconData analysis;
  final IconData graph;
  final IconData graphSelected;
  final IconData overview;
  final IconData overviewSelected;
  final IconData show;
  final IconData hide;
  final IconData sortAsc;
  final IconData sortDesc;

  @override
  ThemeExtension<CustomIcons> copyWith({
    IconData? infoPositive,
    IconData? infoNegative,
    IconData? save,
    IconData? check,
    IconData? cancel,
    IconData? editList,
    IconData? checkboxDeselected,
    IconData? checkboxSelected,
    IconData? checkboxCustom,
    IconData? listItemIndicator,
    IconData? add,
    IconData? remove,
    IconData? question,
    IconData? info,
    IconData? settings,
    IconData? search,
    IconData? error,
    IconData? warning,
    IconData? pickFile,
    IconData? pickDirectory,
    IconData? reload,
    IconData? record,
    IconData? create,
    IconData? test,
    IconData? run,
    IconData? reset,
    IconData? toggle,
    IconData? analysis,
    IconData? graph,
    IconData? graphSelected,
    IconData? overview,
    IconData? overviewSelected,
    IconData? show,
    IconData? hide,
    IconData? sortAsc,
    IconData? sortDesc,
  }) {
    return CustomIcons(
      infoPositive: infoPositive ?? this.infoPositive,
      infoNegative: infoNegative ?? this.infoNegative,
      save: save ?? this.save,
      check: check ?? this.check,
      cancel: cancel ?? this.cancel,
      editList: editList ?? this.editList,
      checkboxDeselected: checkboxDeselected ?? this.checkboxDeselected,
      checkboxSelected: checkboxSelected ?? this.checkboxSelected,
      checkboxCustom: checkboxCustom ?? this.checkboxCustom,
      listItemIndicator: listItemIndicator ?? this.listItemIndicator,
      add: add ?? this.add,
      remove: remove ?? this.remove,
      question: question ?? this.question,
      info: info ?? this.info,
      settings: settings ?? this.settings,
      search: search ?? this.search,
      error: error ?? this.error,
      warning: warning ?? this.warning,
      pickFile: pickFile ?? this.pickFile,
      pickDirectory: pickDirectory ?? this.pickDirectory,
      reload: reload ?? this.reload,
      record: record ?? this.record,
      create: create ?? this.create,
      test: test ?? this.test,
      run: run ?? this.run,
      reset: reset ?? this.reset,
      toggle: toggle ?? this.toggle,
      analysis: analysis ?? this.analysis,
      graph: graph ?? this.graph,
      graphSelected: graphSelected ?? this.graphSelected,
      overview: overview ?? this.overview,
      overviewSelected: overviewSelected ?? this.overviewSelected,
      show: show ?? this.show,
      hide: hide ?? this.hide,
      sortAsc: sortAsc ?? this.sortAsc,
      sortDesc: sortDesc ?? this.sortDesc,
    );
  }

  @override
  ThemeExtension<CustomIcons> lerp(
      covariant ThemeExtension<CustomIcons>? other, double t) {
    return t < 0.5 ? this : other as CustomIcons;
  }
}
