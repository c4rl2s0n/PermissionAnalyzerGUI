import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/common/keys.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit(this.settingsCubit, this.sessionCubit)
      : super(const SplashScreenState()) {
    _loadData();
  }

  SettingsCubit settingsCubit;
  SessionCubit sessionCubit;

  Future _loadData() async {
    await _checkPermissions();
    await _performMigration();

    if (settingsCubit.state.adbPath.isNotEmpty) {
      await sessionCubit.loadAdbDevices();
    }
    _setDefaultSettings();

    emit(state.copyWith(isDone: true));
  }

  void _setDefaultSettings(){
    if(settingsCubit.state.workingDirectory.isEmpty){
      settingsCubit.setWorkingDirectory(Modular.get<String>(key: pkAppDirectory));
    }
  }

  Future _performMigration() async {
    // TODO (?)
  }

  Future _checkPermissions() async {
    if (!isMobile()) return;
  }
}
