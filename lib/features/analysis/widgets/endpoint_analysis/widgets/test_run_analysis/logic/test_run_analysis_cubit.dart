import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/endpoint_analysis/logic/logic.dart';

part 'test_run_analysis_cubit.freezed.dart';

class TestRunAnalysisCubit extends Cubit<TestRunAnalysisState> {
  TestRunAnalysisCubit(this.tests) : super(TestRunAnalysisState(tests: tests));

  List<TestRunDto> tests;

  void selectTest(TestRunDto? test) {
    int index = test == null ? -1 : state.tests.indexOf(test);
    emit(state.copyWith(selectedTestIndex: index < 0 ? null : index));
  }
  void selectConnection(TrafficConnection? connection) {
    emit(state.copyWith(selectedConnection: connection));
  }
  void selectPacket(NetworkPacket? packet) {
    int index = packet == null ? -1 : state.packets?.indexOf(packet) ?? -1;
    emit(state.copyWith(selectedPacketIndex: index < 0 ? null : index));
  }
}

@freezed
class TestRunAnalysisState with _$TestRunAnalysisState {
  const TestRunAnalysisState._();

  const factory TestRunAnalysisState({
    required List<TestRunDto> tests,
    int? selectedTestIndex,
    int? selectedPacketIndex,
    TrafficConnection? selectedConnection,
  }) = _TestRunAnalysisState;

  TestRunDto? get selectedTest => selectedTestIndex != null &&
          selectedTestIndex! >= 0 &&
          selectedTestIndex! < tests.length
      ? tests[selectedTestIndex!]
      : null;
  
  List<NetworkPacket>? get packets => selectedTest?.test.packets;
  NetworkPacket? get selectedPacket => packets != null &&
          selectedPacketIndex != null &&
          selectedPacketIndex! >= 0 &&
          selectedPacketIndex! < packets!.length
      ? packets![selectedPacketIndex!]
      : null;
}
