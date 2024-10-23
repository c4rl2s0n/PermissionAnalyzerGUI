import 'package:flutter/material.dart';

import 'package:permission_analyzer_gui/common/common.dart';

InputBorder getTextBoxBorder(BuildContext context) {
  return UnderlineInputBorder(
    borderSide: BorderSide(
      color: context.colors.onBackground,
      width: 1,
    ),
    //borderRadius: BorderRadius.all(context.constants.roundedCornerRadius),
  );
}

InputBorder getErrorTextBoxBorder(BuildContext context) {
  InputBorder tbb = getTextBoxBorder(context);
  return tbb.copyWith(
    borderSide: tbb.borderSide.copyWith(color: context.colors.negative),
  );
}
