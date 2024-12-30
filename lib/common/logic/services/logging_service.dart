import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';

class LoggingService{

  static String logpath = "logs_pag.json";

  static void setupLogger(String documentsPath, {Level loglevel = Level.ALL}){
    logpath = join(documentsPath, logpath);
    Logger.root.level = loglevel;
    Logger.root.onRecord.listen(onRecord);

    FlutterError.onError = onError;
  }

  static void onRecord(LogRecord record) async {
    File logfile = File(logpath);
    if(!await logfile.exists()){
    await logfile.create(recursive: true);
    }
    await logfile.writeAsString(logToJson(record), mode: FileMode.append);
    if (kDebugMode) {
      print(record.toString());
    }
  }


  static String logToJson(LogRecord record) {
    Map<String, dynamic> errorMap = {
      'timestamp': record.time.toString(),
      'level': record.level,
      'message': record.message,
      'error': record.error?.toString(),
      'stackTrace': record.stackTrace?.toString(),
      'zone': record.zone?.toString(),
    };
    return jsonEncode(errorMap);
  }

  static void onError(FlutterErrorDetails details) async {
    File logfile = File(logpath);
    if(!await logfile.exists()){
      await logfile.create(recursive: true);
    }
    await logfile.writeAsString(errorToJson(details), mode: FileMode.append);
    FlutterError.presentError(details);
  }

  static String errorToJson(FlutterErrorDetails details) {
    Map<String, dynamic> errorMap = {
      'timestamp': DateTime.now().toString(),
      'exception': details.exceptionAsString(),
      'stackTrace': details.stack.toString(),
      'context': details.context?.toJsonMap(
        const DiagnosticsSerializationDelegate(
          subtreeDepth: 5,
          includeProperties: true,
        ),
      ),
      'library': details.library.toString(),
    };
    return jsonEncode(errorMap);
  }
}