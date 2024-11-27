import 'dart:async';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/data/data.dart';

class ProjectOverviewCubit extends Cubit<ProjectOverviewState> {
  ProjectOverviewCubit(this._testApplicationRepository, this._testScenarioRepository)
      : super(
          ProjectOverviewState(
              applications: _testApplicationRepository.getAll()),
        ) {
    _initialize();
  }

  void _initialize() {
    applicationWatcher = _testApplicationRepository.watchAll().listen(
          (apps) => emit(state.copyWith(applications: apps)),
        );
  }

  late StreamSubscription applicationWatcher;
  @override
  Future<void> close() async {
    await applicationWatcher.cancel();
    return super.close();
  }

  final ITestApplicationRepository _testApplicationRepository;
  final ITestScenarioRepository _testScenarioRepository;

  void createApplication(TestApplication application) {
    _testApplicationRepository.update(application);
    emit(
      state.copyWith(
        applications: _testApplicationRepository.getAll(),
      ),
    );
  }

  Future delete(TestApplication application) async {
    _testScenarioRepository.deleteForApplication(application.id);
    _testApplicationRepository.delete(application.id);
    Directory fileDir = Directory(application.fileDirectory);
    if (await fileDir.exists()) {
      await fileDir.delete(recursive: true);
    }
  }
}

class ProjectOverviewState extends Equatable {
  const ProjectOverviewState({
    this.applications = const [],
  });

  final List<TestApplication> applications;

  @override
  List<Object?> get props => [applications];

  ProjectOverviewState copyWith({List<TestApplication>? applications}) {
    return ProjectOverviewState(
      applications: applications ?? this.applications,
    );
  }
}
