import 'package:permission_analyzer_gui/data/models/settings.dart';

abstract class ISettingsRepository {
  Settings getSettings();
  void updateSettings(Settings settings);
}
