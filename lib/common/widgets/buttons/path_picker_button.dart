import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_analyzer_gui/common/common.dart';

class PathPickerButton extends StatelessWidget {
  const PathPickerButton({this.dialogTitle = "Select a filepath", required this.onPathSelected, super.key});

  final String dialogTitle;
  final Function(String path) onPathSelected;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        FilePickerResult? file = await FilePickerFactory.getFilePicker()
            .pickFiles(dialogTitle: dialogTitle);
        if (!context.mounted) return;
        String? selectedPath = file?.files.firstOrNull?.path;
        if (selectedPath != null && selectedPath.isNotEmpty) {
          onPathSelected(selectedPath);
        }
      },
      icon: Icon(context.icons.pickFile),
    );
  }
}
