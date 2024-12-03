import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension ElevatedButtonExtension on ElevatedButton {
  Widget withSecondaryStyle(BuildContext context) => ElevatedButtonTheme(
        data: ElevatedButtonThemeData(
          style: context.theme.elevatedButtonTheme.style?.copyWith(
            backgroundColor: const WidgetStatePropertyAll(Colors.white),
            foregroundColor: const WidgetStatePropertyAll(Colors.black),
          ),
        ),
        child: this,
      );

  Widget withDestructiveStyle(BuildContext context) => ElevatedButtonTheme(
        data: ElevatedButtonThemeData(
          style: context.theme.elevatedButtonTheme.style?.copyWith(
            backgroundColor: const WidgetStatePropertyAll(Colors.red),
          ),
        ),
        child: this,
      );
}
