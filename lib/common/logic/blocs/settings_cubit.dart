import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/data/data.dart';
import 'package:flutter_template/l10n/l10n.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._settingsRepository)
      : super(SettingsState.fromSettings(_settingsRepository.getSettings()));
  final ISettingsRepository _settingsRepository;

  void saveSettings() {
    _settingsRepository.updateSettings(state.toSettings());
  }

  void toggleDarkMode() {
    emit(state.copyWith(isDarkMode: !state.isDarkMode));
    saveSettings();
  }
  void setLanguage(String language){
    emit(state.copyWith(language: language));
    saveSettings();
  }
}

class SettingsState extends Equatable {
  const SettingsState({this.isDarkMode = true, this.language = "en"});
  SettingsState.fromSettings(Settings settings)
      : this(
          isDarkMode: settings.isDarkMode,
          language: settings.language,
        );
  Settings toSettings() {
    return Settings(isDarkMode: isDarkMode, language: language,);
  }

  final bool isDarkMode;
  final String language;

  @override
  List<Object?> get props => [isDarkMode, language];

  SettingsState copyWith({
    bool? isDarkMode,
    String? language,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
    );
  }
}
