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
    this.graph = Icons.hub_outlined,
    this.map = Icons.travel_explore,
    this.mapMarker = Icons.cell_tower,
    this.overview = Icons.featured_play_list_outlined,
    this.connections = Icons.cable_outlined,
    this.show = Icons.visibility_outlined,
    this.hide = Icons.visibility_off_outlined,
    this.sortAsc = Icons.arrow_downward,
    this.sortDesc = Icons.arrow_upward,
    this.connectionOut = Icons.arrow_forward,
    this.connectionIn = Icons.arrow_back,
    this.tests = Icons.science_outlined,
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
  final IconData map;
  final IconData mapMarker;
  final IconData overview;
  final IconData connections;
  final IconData show;
  final IconData hide;
  final IconData sortAsc;
  final IconData sortDesc;
  final IconData connectionOut;
  final IconData connectionIn;
  final IconData tests;

  @override
  ThemeExtension<CustomIcons> copyWith() => this;



  @override
  ThemeExtension<CustomIcons> lerp(
      covariant ThemeExtension<CustomIcons>? other, double t) {
    return t < 0.5 ? this : other as CustomIcons;
  }
}
