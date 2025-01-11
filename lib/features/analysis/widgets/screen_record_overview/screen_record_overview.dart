import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/logic/logic.dart';
import 'package:video_player/video_player.dart';
//import 'package:fvp/fvp.dart';

class ScreenRecordOverview extends StatelessWidget {
  const ScreenRecordOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AnalysisCubit, AnalysisState>(builder: (context, state) {
      List<TestRun> tests = state.enabledGroups
          .fold(<TestRun>[], (all, g) => [...all, ...g.group.tests])
          .where((t) => t.screenRecordPath.notEmpty)
          .toList();
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
                .map((t) => Container(
                      width: size,
                      //height: size,
                      child: _ButterFlyAssetVideo(t.screenRecordPath!),
                    ))
                .toList(),
          );
        },
      );
    });
  }
}

class _ButterFlyAssetVideo extends StatefulWidget {
  _ButterFlyAssetVideo(this.file);
  final String file;
  @override
  _ButterFlyAssetVideoState createState() => _ButterFlyAssetVideoState();
}

class _ButterFlyAssetVideoState extends State<_ButterFlyAssetVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    var file = File(widget.file);
    if (!file.existsSync()) return;
    _controller = VideoPlayerController.file(file);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(false);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            VideoPlayer(_controller),
            //_ControlsOverlay(controller: _controller),
            VideoProgressIndicator(_controller, allowScrubbing: true),
          ],
        ),
      ),
    );
  }
}
