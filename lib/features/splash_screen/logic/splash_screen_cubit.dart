import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:permission_analyzer_gui/common/common.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit(this.sessionCubit) : super(const SplashScreenState()) {
    _loadData();
  }

  SessionCubit sessionCubit;


  Future _loadData() async {
    await _checkPermissions();
    await _performMigration();

    await sessionCubit.loadAdbDevices();
    await sessionCubit.loadAdbDeviceEventInputs();

    emit(state.copyWith(isDone: true));
  }

  Future _performMigration() async {
    // TODO (?)
  }

  Future _checkPermissions() async {
    if(!isMobile()) return;
  }
}
