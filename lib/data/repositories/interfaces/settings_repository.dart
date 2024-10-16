

import 'package:flutter_template/data/models/settings.dart';

abstract class ISettingsRepository{
  Settings getSettings();
  void updateSettings(Settings settings);
}