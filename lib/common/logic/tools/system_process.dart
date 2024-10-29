import 'dart:async';
import 'dart:convert';
import 'dart:io';


class SystemProcess {
  SystemProcess({
    this.workingDirectory,
    this.environment,
    this.includeParentEnvironment = true,
    this.runInShell = false,
    this.mode = ProcessStartMode.normal,
  });

  String? workingDirectory;
  Map<String, String>? environment;
  bool includeParentEnvironment;
  bool runInShell;
  ProcessStartMode mode;

  Future<Process> start(
    String executable,
    List<String> arguments, {
    Duration? timeout,
  }) async {
    Process process = await Process.start(
      executable,
      arguments,
      workingDirectory: workingDirectory,
      environment: environment,
      includeParentEnvironment: includeParentEnvironment,
      runInShell: runInShell,
      mode: mode,
    );
    if (timeout != null) {
      Future.delayed(timeout, () => process.kill());
    }
    return process;
  }

  Future<ProcessResult> run(
    String executable,
    List<String> arguments,
  ) async {
    return Process.run(
      executable,
      arguments,
      workingDirectory: workingDirectory,
      environment: environment,
      includeParentEnvironment: includeParentEnvironment,
      runInShell: runInShell,
    );
  }

  static Future<String?> which(String executable) async {
    var result = await Process.run("which", [executable]);
    if (result.exitCode < 0) return null;
    return result.stdout.toString();
  }
}

/// run response helper.
extension ProcessResultText on ProcessResult {
  Iterable<String> _outStringToLines(String out) => out.split("\n");

  /// Join the out lines for a quick string access.
  String get outText => outLines.join('\n');

  /// Join the out lines for a quick string access.
  String get errText => errLines.join('\n');

  /// Out line lists
  Iterable<String> get outLines => _outStringToLines(this.stdout.toString());

  /// Line lists
  Iterable<String> get errLines => _outStringToLines(this.stderr.toString());
}

/// run response helper.
extension ProcessText on Process {
  Stream<String> _streamLines (Stream<List<int>> raw) => raw.map((l) => utf8.decode(l));
  
  Future<String> get outText async => (await outLines.toList()).join("\n");
  Future<String> get errText async => (await errLines.toList()).join("\n");

  /// Out line lists
  Stream<String> get outLines => _streamLines(this.stdout);

  /// Line lists
  Stream<String> get errLines => _streamLines(this.stderr);
}
