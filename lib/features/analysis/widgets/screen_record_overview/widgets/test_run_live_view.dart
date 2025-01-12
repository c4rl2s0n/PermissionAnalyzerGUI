import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:video_player/video_player.dart';

import 'connection_live_chart.dart';

class TestRunLiveView extends StatefulWidget {
  const TestRunLiveView(this.test, {super.key});
  final TestRun test;
  @override
  TestRunLiveViewState createState() => TestRunLiveViewState();
}

class TestRunLiveViewState extends State<TestRunLiveView> {
  late VideoPlayerController _controller;
  TestRun get test => widget.test;
  int get secondInt => second.floor();
  double second = 0;

  @override
  void initState() {
    super.initState();

    if (test.screenRecordPath.empty) return;
    var file = File(test.screenRecordPath!);
    if (!file.existsSync()) return;
    _controller = VideoPlayerController.file(file);
    _controller.addListener(() async{
      Duration? position = await _controller.position;
      print(position.toString());
      double? timeMs = position?.inMilliseconds.toDouble();
      setState(() {
        if(timeMs != null) {
          second = timeMs / 1000;
        }
      });
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
    return SingleChildScrollView(
      child: Column(
        children: [
          _video(),
          //_timeline(),
          //MyBarChart(),
          ConnectionLiveChart(test.connectionTimeline, time: second,),
        ],
      ),
    );
  }

  Widget _timeline() {
    return Text(
      test.connectionTimeline.keys
          .map((c) => "$c => ${test.connectionTimeline[c]![secondInt]?.bytesTotal ?? 0}")
          .join("\n"),
    );
  }

  Widget _video() {
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
