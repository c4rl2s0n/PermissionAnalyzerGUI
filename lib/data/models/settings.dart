import 'package:isar/isar.dart';

part 'settings.g.dart';

@collection
class Settings{
  Settings({this.isDarkMode=true, this.language="en",});

  Id id = 1;
  final bool isDarkMode;
  final String language;
}