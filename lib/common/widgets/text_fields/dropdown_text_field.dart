import 'package:flutter/material.dart';

import 'package:permission_analyzer_gui/common/common.dart';

class DropdownTextField extends StatefulWidget {
  const DropdownTextField({
    this.initialValue = "",
    this.labelText = "",
    this.hintText = "",
    this.options = const [],
    this.validate,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.padding,
    this.updateWhenInvalid = false,
    super.key,
  });

  final String labelText;
  final String hintText;
  final String initialValue;
  final List<String> options;
  final String? Function(String?)? validate;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final EdgeInsets? padding;
  final bool updateWhenInvalid;

  @override
  State<DropdownTextField> createState() => _DropdownTextFieldState();
}

class _DropdownTextFieldState extends State<DropdownTextField> {
  late TextEditingController controller;

  String? _errorText;
  void _validate() {
    setState(() {
      _errorText = widget.validate?.call(controller.text);
    });
  }

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialValue);
    controller.addListener(() {
      _validate();
      if (_errorText == null || widget.updateWhenInvalid) {
        widget.onChanged?.call(controller.text);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding:
          widget.padding ?? EdgeInsets.only(bottom: context.constants.spacing),
      child: TextFormField(
        style: theme.textTheme.bodyLarge,
        controller: controller,
        decoration: InputDecoration(
          border: getTextBoxBorder(context),
          enabledBorder: getTextBoxBorder(context),
          focusedBorder: getTextBoxBorder(context),
          focusedErrorBorder: getErrorTextBoxBorder(context),
          labelStyle: theme.textTheme.labelLarge,
          labelText: widget.labelText,
          hintText: widget.hintText,
          errorText: _errorText,
          suffixIcon: PopupMenuButton<String>(
            initialValue: "",
            icon: Icon(
              Icons.arrow_drop_down,
              color: theme.iconTheme.color,
            ),
            onSelected: (String item) {
              controller.text = item;
            },
            itemBuilder: (BuildContext context) => widget.options
                .map(
                  (v) => PopupMenuItem<String>(
                    value: v,
                    child: Text(v, style: context.textTheme.labelLarge,),
                  ),
                )
                .toList(),
          ),
        ),
        keyboardType: widget.keyboardType,
      ),
    );
  }
}
