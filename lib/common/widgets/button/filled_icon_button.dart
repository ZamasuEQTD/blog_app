
import 'package:flutter/material.dart';

class ColoredIconButton extends IconButton {
  const ColoredIconButton({
    super.key, 
    required super.onPressed, 
    required super.icon
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: super.build(context)
      );
  }
}