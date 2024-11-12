import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerFactory {
  static FilePicker getFilePicker() {
    if (Platform.isLinux) {
      return FilePickerLinux();
    } else if (Platform.isMacOS) {
      return FilePickerMacOS();
    } else if (Platform.isWindows) {
      return FilePickerWindows();
    }
    throw UnsupportedError("No file picker available for this platform!");
  }
}
