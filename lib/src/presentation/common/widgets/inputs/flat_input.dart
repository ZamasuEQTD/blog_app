import 'package:flutter/material.dart';

class InputFlatField extends StatelessWidget {
  final Widget? suffix;
  final String? hintText;
  final InputDecorationTheme? decoration;
  final bool obscureText;
  final BorderRadius? borderRadius;
  const InputFlatField({
    super.key, 
    this.suffix, 
    this.decoration,
    this.obscureText = false, 
    this.borderRadius, 
    this.hintText, 
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius?? BorderRadius.circular(5),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          suffix: suffix,
        ).applyDefaults(decoration?.merge(defaultTheme)?? defaultTheme),
        obscureText: obscureText,
      )
    );
  }


  static const InputDecorationTheme defaultTheme = InputDecorationTheme(
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    filled: true,
  );
}
