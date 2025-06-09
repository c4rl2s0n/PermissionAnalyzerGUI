import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class ExecutionModule{

  ExecutionModule({DateTime? startTime, this.duration}){
    this.startTime = startTime ?? DateTime.now();
  }

  late DateTime startTime;
  Duration? duration;
  bool finished = false;

  FutureOr start();

  @mustCallSuper
  FutureOr stop([Object? argument]) => finished = true;

}