import 'package:flutter/material.dart';
import 'package:get/get.dart';

const ButtonStyle whiteButtonStyle = ButtonStyle(
  backgroundColor: WidgetStatePropertyAll(Colors.white),
  foregroundColor: WidgetStatePropertyAll(Colors.black),
);

const ButtonStyle redButtonStyle = ButtonStyle(
  backgroundColor: WidgetStatePropertyAll(Colors.red),
  foregroundColor: WidgetStatePropertyAll(Colors.white),
);

ButtonStyle greyButtonStyle = ButtonStyle(
  backgroundColor:
      WidgetStatePropertyAll(const Color(0xff3d3d3d).withOpacity(0.5)),
  foregroundColor:
      WidgetStatePropertyAll(const Color(0x007f7f7f).withOpacity(0.2)),
);

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
