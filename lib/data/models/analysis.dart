import 'package:isar/isar.dart';
import 'package:permission_analyzer_gui/data/models/models.dart';

part 'analysis.g.dart';

@embedded
class Analysis {
  Analysis({
    this.endpointAnalysis,
  });

  EndpointAnalysis? endpointAnalysis;
}
