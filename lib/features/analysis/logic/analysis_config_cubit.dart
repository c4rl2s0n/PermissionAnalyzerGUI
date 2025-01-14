import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_analyzer_gui/common/logic/blocs/settings_cubit.dart';

import 'package:permission_analyzer_gui/data/models/models.dart';

part 'analysis_config_cubit.freezed.dart';

class AnalysisConfigCubit extends Cubit<AnalysisConfigState> {
  AnalysisConfigCubit(this.settings)
      : super(
            AnalysisConfigState.fromConfig(settings.settings.analysisConfig!)) {
    config = settings.settings.analysisConfig!;
  }

  final SettingsCubit settings;
  late final AnalysisConfig config;

  void setGroupConnections(bool groupConnections) {
    config.groupConnections = groupConnections;
    emit(state.copyWith(groupConnections: groupConnections));
    settings.saveSettings();
  }

  void setSniInDomain(bool sniInDomain) {
    config.sniInDomain = sniInDomain;
    emit(state.copyWith(sniInDomain: sniInDomain));
    settings.saveSettings();
  }

  void setShowPort(bool showPort) {
    config.showPort = showPort;
    emit(state.copyWith(showPort: showPort));
    settings.saveSettings();
  }
  void setShowLocation(bool showLocation) {
    config.showLocation = showLocation;
    emit(state.copyWith(showLocation: showLocation));
    settings.saveSettings();
  }

  void setTrafficLoadInPackets(bool loadInPackets) {
    config.trafficLoadInPackets = loadInPackets;
    emit(state.copyWith(trafficLoadInPackets: loadInPackets));
    settings.saveSettings();
  }

  void setShowTestsInGroupTable(bool showTests) {
    config.showTestsInGroupTable = showTests;
    emit(state.copyWith(showTestsInGroupTable: showTests));
    settings.saveSettings();
  }
}

@freezed
class AnalysisConfigState with _$AnalysisConfigState {
  const AnalysisConfigState._();
  const factory AnalysisConfigState({
    required bool trafficLoadInPackets,
    required bool showTestsInGroupTable,
    required bool groupConnections,
    required bool showLocation,
    required bool showPort,
    required bool sniInDomain,
  }) = _AnalysisConfigState;

  factory AnalysisConfigState.fromConfig(AnalysisConfig c) =>
      AnalysisConfigState(
        trafficLoadInPackets: c.trafficLoadInPackets,
        showTestsInGroupTable: c.showTestsInGroupTable,
        groupConnections: c.groupConnections,
        showLocation: c.showLocation,
        showPort: c.showPort,
        sniInDomain: c.sniInDomain,
      );
}
