import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit(this._settingsCubit) : super(const SessionState()) {
    _initialize();
  }
  final SettingsCubit _settingsCubit;

  Future _initialize()async{
    await loadAdbDevices();
    if(state.adbDevices.isNotEmpty){
      await setAdbDevice(state.adbDevices.first);
    }
  }

  bool _checkAdbDevice(){
    if(state.hasDevice){
      return true;
    }
    emit(const SessionState());
    return false;
  }

  Future setAdbDevice(String adbDevice) async {
    emit(state.copyWith(adbDevice: adbDevice));
    await Adb(_settingsCubit, device: adbDevice).root();
    await loadAdbDeviceEventInputs();
    await loadNetworkInterfaces();
  }

  Future loadAdbDevices() async {
    Adb adb = Adb(_settingsCubit);
    List<String> devices = await adb.devices();
    emit(state.copyWith(adbDevices: devices));
  }

  Future loadAdbDeviceEventInputs() async {
    if (!_checkAdbDevice()) return;
    Adb adb = Adb(_settingsCubit, device: state.adbDevice);
    List<AndroidInputDevice> deviceInputs = await adb.getDeviceInputs();
    emit(state.copyWith(adbDeviceEventInputs: deviceInputs));
  }

  Future loadNetworkInterfaces() async {
    if(!_checkAdbDevice()) return;
    Tshark tshark = Tshark(_settingsCubit);
    List<TsharkNetworkInterface> interfaces = await tshark.getInterfaces();
    emit(state.copyWith(networkInterfaces: interfaces));
  }


  Future loadApplications() async {
    if (!_checkAdbDevice()) return;
    Adb adb = Adb(_settingsCubit, device: state.adbDevice);
    List<AndroidInputDevice> deviceInputs = await adb.getDeviceInputs();
    emit(state.copyWith(adbDeviceEventInputs: deviceInputs));
  }
}

class SessionState extends Equatable {
  const SessionState({
    this.adbDevice = "",
    this.adbDevices = const [],
    this.adbDeviceEventInputs = const [],
    this.networkInterfaces = const [],
    this.applications = const [],
  });

  final String adbDevice;
  bool get hasDevice => adbDevice.isNotEmpty;

  final List<String> adbDevices;
  final List<AndroidInputDevice> adbDeviceEventInputs;

  List<AndroidInputDevice> get inputDevices {
    List<AndroidInputDevice> devices = List.of(adbDeviceEventInputs);
    devices.sort((a, b) => a.path.length != b.path.length
        ? a.path.length.compareTo(b.path.length)
        : a.path.compareTo(b.path));
    return devices;
  }

  final List<TsharkNetworkInterface> networkInterfaces;

  final List<TestApplication> applications;

  @override
  List<Object?> get props => [
        adbDevice,
        adbDevices,
        adbDeviceEventInputs,
        networkInterfaces,
        applications,
      ];

  SessionState copyWith({
    String? adbDevice,
    List<String>? adbDevices,
    List<AndroidInputDevice>? adbDeviceEventInputs,
    List<TsharkNetworkInterface>? networkInterfaces,
    List<TestApplication>? applications,
  }) {
    return SessionState(
      adbDevice: adbDevice ?? this.adbDevice,
      adbDevices: adbDevices ?? this.adbDevices,
      adbDeviceEventInputs: adbDeviceEventInputs ?? this.adbDeviceEventInputs,
      networkInterfaces: networkInterfaces ?? this.networkInterfaces,
      applications: applications ?? this.applications,
    );
  }
}
