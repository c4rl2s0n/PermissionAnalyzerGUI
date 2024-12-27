import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';

class TestApplicationCubit extends Cubit<TestApplicationState> {
  TestApplicationCubit(
    this._sessionCubit,
    this.application,
    this.testApplicationRepository,
    this.testScenarioRepository,
  ) : super(
          TestApplicationState(
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
        testScenarioRepository.loadTests(scenarios);
        emit(state.copyWith(scenarios: List.of(scenarios)));
      },
    );
  }

  late StreamSubscription scenarioWatcher;
  @override
  Future<void> close() async {
    await scenarioWatcher.cancel();
    return super.close();
  }

  SessionCubit _sessionCubit;
  TestApplication application;
  ITestApplicationRepository testApplicationRepository;
  ITestScenarioRepository testScenarioRepository;

  Future<TestScenario> newScenario() async {
    String fileDirectory = await _getScenarioFileDirectory();
    TestScenario scenario = TestScenario(
      applicationId: state.id,
      applicationName: state.name,
      fileDirectory: fileDirectory,
      device: _sessionCubit.state.adbDevice,
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

class TestApplicationState extends Equatable {
  const TestApplicationState({
    this.name = "",
    this.id = "",
    this.iconPath,
    this.fileDirectory = "",
    this.scenarios = const [],
  });

  final String name;
  final String id;
  final String? iconPath;
  final String fileDirectory;

  final List<TestScenario> scenarios;

  @override
  List<Object?> get props => [name, id, iconPath, fileDirectory, scenarios];

  TestApplicationState copyWith({
    String? name,
    String? id,
    String? iconPath,
    String? fileDirectory,
    List<TestScenario>? scenarios,
  }) {
    return TestApplicationState(
      name: name ?? this.name,
      iconPath: iconPath ?? this.iconPath,
      fileDirectory: fileDirectory ?? this.fileDirectory,
      id: id ?? this.id,
      scenarios: scenarios ?? this.scenarios,
    );
  }
}
