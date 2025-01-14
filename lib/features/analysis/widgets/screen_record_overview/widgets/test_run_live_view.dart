import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/screen_record_overview/logic/context_extension.dart';
import 'package:permission_analyzer_gui/features/analysis/widgets/screen_record_overview/widgets/timeline_selection_dialog.dart';
import 'package:video_player/video_player.dart';


class TestRunLiveView extends StatefulWidget {
  const TestRunLiveView(
    this.test, {
    this.size,
    this.onDurationUpdate,
    this.playPauseStream,
    this.restartStream,
    this.seekToStream,
    super.key,
  });
  final TestRun test;
  final Size? size;
  final Function(Duration)? onDurationUpdate;
  final Stream<bool>? playPauseStream;
  final Stream<void>? restartStream;
  final Stream<Duration>? seekToStream;
  @override
  TestRunLiveViewState createState() => TestRunLiveViewState();
}

class TestRunLiveViewState extends State<TestRunLiveView> {
  VideoPlayerController? _controller;
  TestRun get test => widget.test;

  List<StreamSubscription?> listener = [];

  @override
  void initState() {
    super.initState();
    // load the recording-file
    if (test.screenRecordPath.empty) return;
    var file = File(test.screenRecordPath!);
    if (!file.existsSync()) return;
    _controller = VideoPlayerController.file(file);
    if (widget.onDurationUpdate != null) {
      _controller?.addListener(() async {
        Duration? position = await _controller?.position;
        if (position != null) widget.onDurationUpdate!(position);
      });
    }
    _controller?.setLooping(false);
    _controller?.initialize().then((_) => _setupControlsListener());
    //_controller?.play();
  }
  void _setupControlsListener(){
    // Restart
    listener.add(widget.restartStream?.listen((_) async {
      await _controller?.seekTo(Duration.zero);
      await _controller?.play();
    }));
    // Play/Pause
    listener.add(widget.playPauseStream?.listen((play) async {
      if(play) {
        await _controller?.play();
      }else{
        await _controller?.pause();
      }
    }));
    // SeekTo
    listener.add(widget.seekToStream?.listen((pos) async {
      await _controller?.seekTo(pos);
    }));

    setState(() {});
  }

  @override
  void dispose() {
    for(var l in listener){
      l?.cancel();
    }
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return SizedBox(
    //   width: widget.size?.width,
    //   child: Column(
    //     mainAxisSize: MainAxisSize.min,
    //     children: [
    //       Row(
    //         children: [
    //           Text("Hallo"),
    //           Expanded(child: Text("Hallo")),
    //           Text("Hallo"),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
    return SizedBox(
      width: widget.size?.width,
      height: widget.size?.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(test.name),
              _monitorSelection(context),
            ],
          ),
          Expanded(child: _video()),
        ].insertBetweenItems(() => Margin.vertical(context.constants.spacing)),
      ),
    );
  }

  Widget _video() {
    if (_controller == null) return const Text("Screen Record not found...");
    double aspectRatio = _controller!.value.aspectRatio;
    Size? size;
    if (widget.size != null) {
      size = Size(
          widget.size!.width * aspectRatio, widget.size!.height / aspectRatio);
    }
    return Optional(
      buildOptional: (child) => SizedBox.fromSize(
        size: size,
        child: child,
      ),
      useOptional: size != null,
      child: Center(
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              VideoPlayer(_controller!),
              //_ControlsOverlay(controller: _controller),
              VideoProgressIndicator(_controller!, allowScrubbing: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _monitorSelection(BuildContext context) {
    return IconButton(
      icon: Icon(context.icons.test),
      onPressed: () async {
        await TimelineSelectionDialog.showTimelineSelection(
          context,
          test,
          context.overviewCubit,
        );
      },
    );
  }
}
