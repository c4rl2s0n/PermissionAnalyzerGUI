import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:permission_analyzer_gui/common/common.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({
    this.currentColor,
    this.closeOnSelection = true,
    this.availableColors,
    super.key,
  });

  final Color? currentColor;
  final bool closeOnSelection;
  final List<Color>? availableColors;
  static const List<Color> colors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
  ];

  @override
  State<ColorPicker> createState() => _ColorPickerState();

  static Future<Color?> selectColor(
    BuildContext context, {
    List<Color>? availableColors,
    Color? currentColor,
  }) async {
    return await showDialog<Color?>(
      barrierDismissible: true,
      builder: (context) => ColorPicker(
        availableColors: availableColors,
        currentColor: currentColor,
      ),
      context: context,
    );
  }

  static Widget openButton(
    BuildContext context, {
    required Function(Color?) onColorSelected,
    List<Color>? availableColors,
    Color? selectedColor,
  }) {
    return IconButton(
      onPressed: () async => onColorSelected(await selectColor(
        context,
        availableColors: availableColors,
        currentColor: selectedColor,
      )),
      icon: Icon(context.icons.color),
      color: selectedColor,
    );
  }
}

class _ColorPickerState extends State<ColorPicker> {
  late List<Color> availableColors;
  Color? selectedColor;

  @override
  void initState() {
    availableColors =  widget.availableColors ?? ColorPicker.colors;
    selectedColor = widget.currentColor ?? availableColors.firstOrNull;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      expand: false,
      title: 'Pick a color!',
      actions: const [CloseButton()],
      content: SingleChildScrollView(
        child: BlockPicker(
          availableColors: availableColors,
          pickerColor: selectedColor,
          onColorChanged: (color) => setState(() {
            selectedColor = color;
            if (widget.closeOnSelection) {
              context.navigator.maybePop(selectedColor);
            }
          }),
        ),
      ),
    );
  }
}
