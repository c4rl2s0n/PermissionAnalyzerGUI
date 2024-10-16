import 'dart:ui';

import 'package:flutter/scheduler.dart';
import 'package:flutter_template/data/data.dart';
import 'package:isar/isar.dart';

class SettingsRepository extends ISettingsRepository {
  SettingsRepository(this._isar);
  final Isar _isar;

  @override
  Settings getSettings() {
    return _isar.settings.getSync(1) ??
        Settings(
          isDarkMode:
              SchedulerBinding.instance.platformDispatcher.platformBrightness ==
                  Brightness.dark,
        );
  }

  @override
  void updateSettings(Settings settings) {
    _isar.writeTxnSync(() => _isar.settings.putSync(settings));
  }
}
