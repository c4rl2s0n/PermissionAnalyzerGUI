import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_analyzer_gui/common/keys.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'settings_cubit.freezed.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settingsRepository) : super(SettingsState.empty()) {
    settings = _settingsRepository.getSettings();
    emit(SettingsState.fromSettings(settings));
  }
  final ISettingsRepository _settingsRepository;
  late final Settings settings;

  void saveSettings() {
    _settingsRepository.updateSettings(settings);
  }

  void toggleDarkMode() {
    settings.isDarkMode = !settings.isDarkMode;
    emit(state.copyWith(isDarkMode: settings.isDarkMode));
    saveSettings();
  }

  void toggleIgnoreLocalTraffic() {
    settings.ignoreLocalTraffic = !settings.ignoreLocalTraffic;
    emit(state.copyWith(ignoreLocalTraffic: settings.ignoreLocalTraffic));
    saveSettings();
  }

  void setLanguage(String language) {
    settings.language = language;
    emit(state.copyWith(language: language));
    saveSettings();
  }

  void setAdbPath(String path) {
    settings.adbPath = path;
    emit(state.copyWith(adbPath: path));
    saveSettings();
  }

  void setTsharkPath(String path) {
    settings.tsharkPath = path;
    emit(state.copyWith(tsharkPath: path));
    saveSettings();
  }

  Future setRecorder(String version) async {
    emit(state.copyWith(recorderVersion: version));
    saveSettings();
  }
  void setRecorderPath(String path) {
    settings.recorderPath = path;
    emit(state.copyWith(recorderPath: path));
    saveSettings();
  }

  void setRecorderDestinationPath(String path) {
    settings.recorderDestinationPath = path;
    emit(state.copyWith(recorderDestinationPath: path));
    saveSettings();
  }

  void setInputRecordDestinationPath(String path) {
    settings.inputRecordDestinationPath = path;
    emit(state.copyWith(recorderDestinationPath: path));
    saveSettings();
  }

  void setWorkingDirectory(String path) {
    settings.workingDirectory = path;
    emit(state.copyWith(workingDirectory: path));
    saveSettings();
  }

}

@freezed
class SettingsState with _$SettingsState {
  const SettingsState._();

  const factory SettingsState({
    required bool isDarkMode,
    required String language,
    required bool ignoreLocalTraffic,
    required String workingDirectory,
    required String adbPath,
    required String tsharkPath,
    required String recorderVersion,
    required String recorderPath,
    required String recorderDestinationPath,
    required String inputRecordDestinationPath,
  }) = _SettingsState;

  factory SettingsState.empty() => SettingsState(
        isDarkMode: true,
        language: "en",
        ignoreLocalTraffic: true,
        workingDirectory: "",
        adbPath: "",
        tsharkPath: "",
        recorderVersion: recorderVersions.first,
        recorderPath: "",
        recorderDestinationPath: defaultRecorderDestinationPath,
        inputRecordDestinationPath: defaultInputRecordDestinationPath,
      );

  factory SettingsState.fromSettings(Settings settings) => SettingsState(
        isDarkMode: settings.isDarkMode,
        language: settings.language,
        ignoreLocalTraffic: settings.ignoreLocalTraffic,
        workingDirectory: settings.workingDirectory ?? "",
        adbPath: settings.adbPath ?? "",
        tsharkPath: settings.tsharkPath ?? "",
        recorderVersion: settings.recorderVersion ?? recorderVersions.first,
        recorderPath: settings.recorderPath ?? "",
        recorderDestinationPath:
            settings.recorderDestinationPath ?? defaultRecorderDestinationPath,
        inputRecordDestinationPath: settings.inputRecordDestinationPath ??
            defaultInputRecordDestinationPath,
      );
  static const List<String> recorderVersions = [
    "x86_64",
    "x86",
    "arm64-v8a",
    "armeabi-v7",
  ];
}
// class SettingsState extends Equatable {
//   const SettingsState({
//     this.isDarkMode = true,
//     this.language = "en",
//     this.workingDirectory = "",
//     this.adbPath = "",
//     this.tsharkPath = "",
//     this.recorderVersion = "",
//     this.recorderPath = "",
//     this.recorderDestinationPath = defaultRecorderDestinationPath,
//     this.inputRecordDestinationPath = defaultInputRecordDestinationPath,
//   });
//   SettingsState.fromSettings(Settings settings)
//       : this(
//           isDarkMode: settings.isDarkMode,
//           language: settings.language,
//           workingDirectory: settings.workingDirectory ?? "",
//           adbPath: settings.adbPath ?? "",
//           tsharkPath: settings.tsharkPath ?? "",
//           recorderPath: settings.recorderPath ?? "",
//           recorderDestinationPath: settings.recorderDestinationPath ??
//               defaultRecorderDestinationPath,
//           inputRecordDestinationPath: settings.inputRecordDestinationPath ??
//               defaultInputRecordDestinationPath,
//         );
//
//   final bool isDarkMode;
//   final String language;
//   final String workingDirectory;
//   final String adbPath;
//   final String tsharkPath;
//   final String recorderPath;
//   final String recorderDestinationPath;
//   final String inputRecordDestinationPath;
//
//   @override
//   List<Object?> get props => [
//         isDarkMode,
//         language,
//         workingDirectory,
//         adbPath,
//         tsharkPath,
//         recorderPath,
//         recorderDestinationPath,
//         inputRecordDestinationPath,
//       ];
//
//   SettingsState copyWith({
//     bool? isDarkMode,
//     String? language,
//     String? workingDirectory,
//     String? adbPath,
//     String? tsharkPath,
//     String? recorderPath,
//     String? recorderDestinationPath,
//     String? inputRecordDestinationPath,
//   }) {
//     return SettingsState(
//       isDarkMode: isDarkMode ?? this.isDarkMode,
//       language: language ?? this.language,
//       workingDirectory: workingDirectory ?? this.workingDirectory,
//       adbPath: adbPath ?? this.adbPath,
//       tsharkPath: tsharkPath ?? this.tsharkPath,
//       recorderPath: recorderPath ?? this.recorderPath,
//       recorderDestinationPath:
//           recorderDestinationPath ?? this.recorderDestinationPath,
//       inputRecordDestinationPath:
//           inputRecordDestinationPath ?? this.inputRecordDestinationPath,
//     );
//   }
// }
