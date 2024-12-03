import 'package:flutter/material.dart';

class ColoredIconButton extends IconButton {
  final Color? background;
  final BorderRadius? border;

  const ColoredIconButton({
    super.key,
    this.background,
    this.border,
    required super.onPressed,
    required super.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color color = background ?? Theme.of(context).colorScheme.onSurface;
    if (border == null) {
      return ClipOval(
        child: ColoredBox(color: color, child: super.build(context)),
      );
    }

    return ClipRRect(
      borderRadius: border!,
      child: ColoredBox(color: color, child: super.build(context)),
    );
  }
}
