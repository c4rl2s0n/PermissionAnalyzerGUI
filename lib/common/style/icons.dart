import 'package:flutter/material.dart';

class CustomIcons extends ThemeExtension<CustomIcons> {
  const CustomIcons({
    this.infoPositive = Icons.verified,
    this.infoNegative = Icons.error_outline,
    this.save = Icons.save,
    this.check = Icons.check_circle_outline,
    this.cancel = Icons.cancel_outlined,
    this.editList = Icons.edit_note,
    this.checkboxEmpty = Icons.check_box_outline_blank,
    this.checkboxSelected = Icons.check_box,
    this.checkboxDeselected = Icons.indeterminate_check_box,
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
  });

  final IconData infoPositive;
  final IconData infoNegative;
  final IconData save;
  final IconData check;
  final IconData cancel;
  final IconData editList;
  final IconData checkboxEmpty;
  final IconData checkboxSelected;
  final IconData checkboxDeselected;
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

  @override
  ThemeExtension<CustomIcons> copyWith({
    IconData? infoPositive,
    IconData? infoNegative,
    IconData? save,
    IconData? check,
    IconData? cancel,
    IconData? editList,
    IconData? checkboxEmpty,
    IconData? checkboxSelected,
    IconData? checkboxDeselected,
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
  }) {
    return CustomIcons(
      infoPositive: infoPositive ?? this.infoPositive,
      infoNegative: infoNegative ?? this.infoNegative,
      save: save ?? this.save,
      check: check ?? this.check,
      cancel: cancel ?? this.cancel,
      editList: editList ?? this.editList,
      checkboxEmpty: checkboxEmpty ?? this.checkboxEmpty,
      checkboxSelected: checkboxSelected ?? this.checkboxSelected,
      checkboxDeselected: checkboxDeselected ?? this.checkboxDeselected,
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
    );
  }

  @override
  ThemeExtension<CustomIcons> lerp(
      covariant ThemeExtension<CustomIcons>? other, double t) {
    return t < 0.5 ? this : other as CustomIcons;
  }
}
