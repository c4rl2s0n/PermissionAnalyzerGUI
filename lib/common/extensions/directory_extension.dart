import 'dart:io';

extension IsRootDirectory on Directory {
  bool get isRoot => parent.absolute.path == absolute.path;
}
