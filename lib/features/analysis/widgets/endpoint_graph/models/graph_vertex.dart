import 'package:permission_analyzer_gui/common/keys.dart';
import 'package:permission_analyzer_gui/data/data.dart';
import 'package:permission_analyzer_gui/features/analysis/models/models.dart';

abstract class GraphVertex {
  GraphVertex({
    required this.id,
    this.unique = false,
    this.common = false,
    this.size = 0.5,
    this.connectedGroups = 0,
  });

  String id;

  String get name;
  List<String> get tags;
  dynamic get data;
  bool unique;
  bool common;
  double size;
  int connectedGroups;

  // TODO:
  //  - for endpoints: count number of connected groups (map to 0.0-1.0)
  //  - highlight groups with unique endpoints
  //  - highlight endpoints with only one group
}

