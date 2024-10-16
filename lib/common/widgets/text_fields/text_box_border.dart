import 'package:flutter/material.dart';

import 'package:flutter_template/common/common.dart';

OutlineInputBorder getTextBoxBorder(BuildContext context) {
  return OutlineInputBorder(
    borderSide: BorderSide(
      color: context.colors.onBackground,
      width: 2,
    ),
    borderRadius: BorderRadius.all(context.constants.roundedCornerRadius),
  );
}

OutlineInputBorder getErrorTextBoxBorder(BuildContext context) {
  OutlineInputBorder tbb = getTextBoxBorder(context);
  return tbb.copyWith(
    borderSide: tbb.borderSide.copyWith(color: context.colors.negative),
  );
}
