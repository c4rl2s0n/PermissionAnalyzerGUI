import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';
import 'package:permission_analyzer_gui/data/data.dart';

part 'test_application_cubit.freezed.dart';

class TestApplicationCubit extends Cubit<TestApplicationState> {
  TestApplicationCubit(
    this.application,
    this.testApplicationRepository,
    this.testScenarioRepository,
  ) : super(
          TestApplicationState(
            application: application,
            name: application.name,
            id: application.id,
            iconPath: application.iconPath,
            fileDirectory: application.fileDirectory,
            scenarios: testScenarioRepository.getForApplication(application.id),
          ),
        ) {
    _initialize();
  }

  void _initialize() {
    scenarioWatcher =
        testScenarioRepository.watchForApplication(state.id).listen(
      (scenarios) {
        testScenarioRepository.loadExtraDataForScenarios(scenarios);
        emit(state.copyWith(scenarios: List.of(scenarios)));
      },
    );
  }

  StreamSubscription? scenarioWatcher;
  @override
  Future<void> close() async {
    await scenarioWatcher?.cancel();
    return super.close();
  }

  TestApplication application;
  ITestApplicationRepository testApplicationRepository;
  ITestScenarioRepository testScenarioRepository;

  Future<TestScenario> newScenario() async {
    String fileDirectory = await _getScenarioFileDirectory();
    TestScenario scenario = TestScenario(
      applicationId: state.id,
      applicationName: state.name,
      fileDirectory: fileDirectory,
      device: state.application.device,
    );
    testScenarioRepository.update(scenario);
    emit(state.copyWith(
        scenarios: testScenarioRepository.getForApplication(state.id)));
    return scenario;
  }

  Future<String> _getScenarioFileDirectory() async {
    int i = 0;
    String fileDirectory = application.fileDirectory;
    Directory fileDir = Directory(fileDirectory);
    while (await fileDir.exists()) {
      fileDirectory =
          join(application.fileDirectory, i.toString().padLeft(4, "0"));
      fileDir = Directory(fileDirectory);
      i++;
    }
    await fileDir.create(recursive: true);
    return fileDirectory;
  }

  Future delete() async {
    testScenarioRepository.deleteForApplication(state.id);
    testApplicationRepository.delete(state.id);
    Directory fileDir = Directory(state.fileDirectory);
    if (await fileDir.exists()) {
      await fileDir.delete(recursive: true);
    }
  }
}


@freezed
class TestApplicationState with _$TestApplicationState {
  const TestApplicationState._();
  const factory TestApplicationState({
    required TestApplication application,
    required String name,
    required String id,
    String? iconPath,
    required String fileDirectory,
    required List<TestScenario> scenarios,
  }) = _TestApplicationState;
}