
import 'dart:io';

import 'package:flutter/material.dart';

Future performDelayedTap(BuildContext context, void Function() onTap) async {
  // Delay to show ripple-effect before executing the command
  await Future.delayed(
    const Duration(milliseconds: 150),
        () {
      if (context.mounted) onTap.call();
    },
  );
}

bool isDesktop() {
return Platform.isLinux || Platform.isWindows || Platform.isMacOS;
}

bool isMobile() {
return Platform.isAndroid || Platform.isIOS;
}