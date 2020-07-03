import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FocusNode currentFocusNode;
  final FocusNode nextFocusNode;
  final Function(String) validator;
  final Function(String) onChanged;
  final String errorText;
  final bool enabled;
  final bool readOnly;
  final Color textColor;

  InputField({
    this.controller,
    this.labelText,
    this.hintText,
    this.textColor,
    this.suffixIcon,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.currentFocusNode,
    this.nextFocusNode,
    this.validator,
    this.errorText,
    this.onChanged,
    this.enabled = true,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextFormField(
          controller: controller,
          enabled: enabled,
          obscureText: obscureText,
          style: TextStyle(color: enabled ? textColor??Colors.white : Colors.grey),
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          focusNode: currentFocusNode,
          validator: validator,
          readOnly: readOnly,
          onChanged: onChanged,
          onFieldSubmitted: (term) {
            currentFocusNode.unfocus();
            if (nextFocusNode != null) {
              FocusScope.of(context).requestFocus(nextFocusNode);
            }
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: labelText,
              errorText: errorText,
              errorMaxLines: 5,
              labelStyle: TextStyle(
                color: textColor??Colors.white.withAlpha(70),
              ),
              hintText: hintText,
              hintStyle: TextStyle(color: textColor??Colors.white.withAlpha(70)),
              errorStyle: TextStyle(color: Colors.red, fontSize: 15.0),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon),
        ),
        Divider(
          height: 1,
          color: Color(0xFFAAAAAA),
        )
      ],
    );
  }
}
