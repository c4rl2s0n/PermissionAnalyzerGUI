import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:flutter_template/common/common.dart';

part 'splash_screen_state.dart';

class SplashScreenCubit extends Cubit<SplashScreenState> {
  SplashScreenCubit() : super(const SplashScreenState()) {
    _loadData();
  }


  Future _loadData() async {
    await _checkPermissions();
    await _performMigration();

    emit(state.copyWith(isDone: true));
  }

  Future _performMigration() async {
    // TODO (?)
  }

  Future _checkPermissions() async {
    if(!isMobile()) return;
    // if (!await Permission.manageExternalStorage.isGranted) {
    //   await Permission.manageExternalStorage.request();
    // }
  }
}
