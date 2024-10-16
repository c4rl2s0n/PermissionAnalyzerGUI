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
    this.remove = Icons.remove,
    this.question = Icons.question_mark,
    this.info = Icons.info_outline,
    this.settings = Icons.settings,
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
    );
  }

  @override
  ThemeExtension<CustomIcons> lerp(
      covariant ThemeExtension<CustomIcons>? other, double t) {
    return t < 0.5 ? this : other as CustomIcons;
  }
}
