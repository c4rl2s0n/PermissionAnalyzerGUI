// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get title => 'PermissionAnalyzerGui';

  @override
  String get home => 'Dahoam';

  @override
  String get settings => 'Einstellungen';

  @override
  String get darkMode => 'Dunkler Modus';

  @override
  String get themeSettings => 'Erscheinungspräferenzen';

  @override
  String get languageSettings => 'Spracheinstellungen';

  @override
  String get selectedLanguage => 'Ausgewählte Sprache';

  @override
  String get testScenario => 'Test Scenario';

  @override
  String get warning => 'Warning';

  @override
  String get error => 'Error';

  @override
  String get adbSettings => 'ADB Executable Path';

  @override
  String get adbDeviceSettings => 'Android Device Name';

  @override
  String get adbNotFound => 'Could not find ADB on the system.\nSpecify the path manually or install ADB.';

  @override
  String get pickAdbPath => 'Select the path of ADB on your system.';

  @override
  String get tsharkSettings => 'TShark Executable Path';

  @override
  String get tsharkNotFound => 'Could not find TShark on the system.\nSpecify the path manually or install TShark.';

  @override
  String get pickTsharkPath => 'Select the path of TShark on your system.';

  @override
  String get recorderLocalSettings => 'Gesture Recorder Executable Path';

  @override
  String get recorderDestinationSettings => 'Gesture Recorder Destination Path';

  @override
  String get recorderDestinationSettingsDescription => 'Location where the gesture recorder executable will be stored on the test device';

  @override
  String get pickRecorderPath => 'Select the path of gesture recorder executable.';

  @override
  String get pathFound => 'The file was found on your system.';

  @override
  String get path => 'Path';
}
