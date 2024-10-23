import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit(this._settingsCubit) : super(const SessionState()) {
    loadAdbDevices();
  }
  final SettingsCubit _settingsCubit;
  void setAdbDevice(String adbDevice) {
    emit(state.copyWith(adbDevice: adbDevice));
    loadAdbDeviceEventInputs();
  }

  Future loadAdbDevices() async {
    AdbService adb = AdbService(_settingsCubit);
    List<String> devices = await adb.devices();
    emit(state.copyWith(
      adbDevice: state.adbDevice.isEmpty ? devices.firstOrNull : null,
      adbDevices: devices,
    ));
  }

  Future loadAdbDeviceEventInputs() async {
    if(state.adbDevice.isEmpty) return;
    AdbService adb = AdbService(_settingsCubit, device: state.adbDevice);
    Map<String, String> eventDevices = await adb.getEventDevices();
    emit(state.copyWith(adbDeviceEventInputs: eventDevices));
  }
}

class SessionState extends Equatable {
  const SessionState({
    this.adbDevice = "",
    this.adbDevices = const [],
    this.adbDeviceEventInputs = const {},
  });

  final String adbDevice;
  final List<String> adbDevices;
  final Map<String, String> adbDeviceEventInputs;
  List<String> get inputDevices {
    List<String> devices = adbDeviceEventInputs.keys.toList();
    devices.sort((a,b) => a.length != b.length ? a.length.compareTo(b.length) : a.compareTo(b));
    return devices;
  }
  String? inputDeviceInfo(String dev){
    if(adbDeviceEventInputs.containsKey(dev)) return adbDeviceEventInputs[dev];
    return null;
  }

  @override
  List<Object?> get props => [
        adbDevice,
        adbDevices,
        adbDeviceEventInputs,
      ];

  SessionState copyWith({
    String? adbDevice,
    List<String>? adbDevices,
    Map<String, String>? adbDeviceEventInputs,
  }) {
    return SessionState(
      adbDevice: adbDevice ?? this.adbDevice,
      adbDevices: adbDevices ?? this.adbDevices,
      adbDeviceEventInputs: adbDeviceEventInputs ?? this.adbDeviceEventInputs,
    );
  }
}
