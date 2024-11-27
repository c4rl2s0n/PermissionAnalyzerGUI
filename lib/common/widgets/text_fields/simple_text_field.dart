import 'package:flutter/material.dart';

import 'package:permission_analyzer_gui/common/common.dart';

class SimpleTextField extends StatefulWidget {
  const SimpleTextField({
    this.initialValue = "",
    this.labelText = "",
    this.hintText = "",
    this.validate,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.padding,
    this.isPassword = false,
    this.updateWhenInvalid = false,
    this.enabled = true,
    super.key,
  });

  final String labelText;
  final String hintText;
  final String initialValue;
  final String? Function(String?)? validate;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final EdgeInsets? padding;
  final bool isPassword;
  final bool updateWhenInvalid;
  final bool enabled;

  @override
  State<SimpleTextField> createState() => _SimpleTextFieldState();
}

class _SimpleTextFieldState extends State<SimpleTextField> {
  late TextEditingController controller;
  late bool obscured;

  String? _errorText;
  void _validate() {
    setState(() {
      _errorText = widget.validate?.call(controller.text);
    });
  }

  void _toggleObscure() {
    setState(() {
      obscured = !obscured;
    });
  }

  @override
  void didUpdateWidget(covariant SimpleTextField oldTextField) {
    super.didUpdateWidget(oldTextField);
    controller.text = widget.initialValue;
  }

  @override
  void initState() {
    controller = TextEditingController(text: widget.initialValue);
    obscured = widget.isPassword;
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
        enabled: widget.enabled,
        style: theme.textTheme.bodyMedium,
        controller: controller,
        obscureText: obscured,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          border: getTextBoxBorder(context),
          enabledBorder: getTextBoxBorder(context),
          focusedBorder: getTextBoxBorder(context),
          focusedErrorBorder: getErrorTextBoxBorder(context),
          labelStyle: theme.textTheme.labelMedium?.copyWith(
              color: theme.textTheme.labelMedium?.color
                  ?.withOpacity(context.constants.subtleColorOpacity)),
          labelText: widget.labelText,
          hintText: widget.hintText,
          errorText: _errorText,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: _toggleObscure,
                  icon: Icon(
                    Icons.remove_red_eye_outlined,
                    color: theme.iconTheme.color,
                  ),
                )
              : null,
        ),
        keyboardType: widget.keyboardType,
        onChanged: (val) {
          _validate();
          if (_errorText == null || widget.updateWhenInvalid) {
            widget.onChanged?.call(val);
          }
        },
      ),
    );
  }
}
