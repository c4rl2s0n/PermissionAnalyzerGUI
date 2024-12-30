import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'session_cubit.freezed.dart';

class SessionCubit extends Cubit<SessionState> {
  SessionCubit(this._settingsCubit) : super(SessionState.empty()) {
    _initialize();
  }
  final SettingsCubit _settingsCubit;

  Future _initialize() async {
    await loadAdbDevices();
    if (state.adbDevices.isNotEmpty) {
      await setAdbDevice(state.adbDevices.first);
    }
  }

  bool get _hasAdb => _settingsCubit.state.adbPath.isNotEmpty;
  bool get _hasTshark => _settingsCubit.state.tsharkPath.isNotEmpty;

  bool _checkAdbDevice() {
    if (_hasAdb && state.hasDevice) {
      return true;
    }
    emit(SessionState.empty());
    return false;
  }

  Future setAdbDevice(String? adbDevice) async {
    if (adbDevice == null) {
      emit(state.copyWith(
        adbDevice: "",
        adbDeviceEventInputs: [],
        networkInterfaces: [],
      ));
      return;
    }
    emit(state.copyWith(adbDevice: adbDevice));
    await Adb(_settingsCubit, device: adbDevice).root();
    await loadAdbDeviceEventInputs();
    await loadNetworkInterfaces();
  }

  Future loadAdbDevices() async {
    if (!_hasAdb) return;
    Adb adb = Adb(_settingsCubit);
    List<String> devices = await adb.devices();
    emit(state.copyWith(adbDevices: devices));
    if (state.adbDevice.isEmpty || !devices.contains(state.adbDevice)) {
      String? device = devices.firstOrNull;
      setAdbDevice(device);
    }
  }

  Future loadAdbDeviceEventInputs() async {
    if (!_checkAdbDevice()) return;
    Adb adb = Adb(_settingsCubit, device: state.adbDevice);
    List<AndroidInputDevice> deviceInputs = await adb.getDeviceInputs();
    emit(state.copyWith(adbDeviceEventInputs: deviceInputs));
  }

  Future loadNetworkInterfaces() async {
    if (!_checkAdbDevice() || !_hasTshark) return;
    Tshark tshark = Tshark(_settingsCubit);
    List<TsharkNetworkInterface> interfaces = await tshark.getInterfaces();
    emit(state.copyWith(networkInterfaces: interfaces));
  }
}

@freezed
class SessionState with _$SessionState {
  const SessionState._();

  const factory SessionState({
    required String adbDevice,
    required List<String> adbDevices,
    required List<AndroidInputDevice> adbDeviceEventInputs,
    required List<TsharkNetworkInterface> networkInterfaces,
    required List<TestApplication> applications,
  }) = _SessionState;

  factory SessionState.empty() => const SessionState(
        adbDevice: "",
        adbDevices: [],
        adbDeviceEventInputs: [],
        networkInterfaces: [],
        applications: [],
      );
  bool get hasDevice => adbDevice.isNotEmpty;

  bool deviceConnected(String device) => adbDevices.contains(device);

  List<AndroidInputDevice> get inputDevices {
    List<AndroidInputDevice> devices = List.of(adbDeviceEventInputs);
    devices.sort((a, b) => a.path.length != b.path.length
        ? a.path.length.compareTo(b.path.length)
        : a.path.compareTo(b.path));
    return devices;
  }
}
