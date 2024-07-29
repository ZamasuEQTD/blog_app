import 'package:flutter/material.dart';

class ColoredIconButton extends IconButton {
  final BorderRadius? border;

  const ColoredIconButton(
      {super.key, this.border, required super.onPressed, required super.icon});

  @override
  Widget build(BuildContext context) {
    if (border == null) {
      return ClipOval(
        child: ColoredBox(
            color: Theme.of(context).colorScheme.onSurface,
            child: super.build(context)),
      );
    }

    return ClipRRect(
      borderRadius: border!,
      child: ColoredBox(
          color: Theme.of(context).colorScheme.onSurface,
          child: super.build(context)),
    );
  }
}
