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

String permissionToShortcut(String permission) {
  return permission
      .split(".")
      .last
      .split("_")
      .map((p) => p.substring(0, 1))
      .join();
}

Future sleepSec(int seconds) {
  return sleep(Duration(seconds: seconds));
}

Future sleep(Duration duration) {
  return Future.delayed(duration);
}
