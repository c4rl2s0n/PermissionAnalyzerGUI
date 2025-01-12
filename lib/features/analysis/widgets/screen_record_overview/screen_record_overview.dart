import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';
import 'package:video_player/video_player.dart';

import 'widgets/widgets.dart';
//import 'package:fvp/fvp.dart';

class ScreenRecordOverview extends StatelessWidget {
  const ScreenRecordOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(builder: (context, state) {
      List<TestRun> tests = state.enabledGroups
          .fold(<TestRun>[], (all, g) => [...all, ...g.group.tests])
          .where((t) => t.screenRecordPath.notEmpty)
          .toList().distinct;
      String? file = tests
          .where((t) => t.screenRecordPath.notEmpty)
          .firstOrNull
          ?.screenRecordPath;
      double size = 300;
      if (file.empty) return Text("No Record");
      return LayoutBuilder(
        builder: (context, constraints) {
          int count = (constraints.maxWidth / size).floor();
          return GridView.count(
            crossAxisCount: count,
            mainAxisSpacing: context.constants.spacing,
            children: tests
                .sublist(0, 1)//min(tests.length, 15))
                .where((t) => File(t.screenRecordPath!).existsSync())
                .map((t) => Container(
                      width: size,
                      //height: size,
                      child: TestRunLiveView(t),
                    ))
                .toList(),
          );
        },
      );
    });
  }
}

