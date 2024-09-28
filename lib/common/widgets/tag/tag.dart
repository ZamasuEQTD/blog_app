import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final Widget child;
  final Color color;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry? padding;
  const Tag({
    super.key,
    required this.child,
    required this.color,
    required this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = this.child;

    if (padding != null) {
      child = Padding(
        padding: padding!,
        child: child,
      );
    }
    return ClipRRect(
      borderRadius: borderRadius,
      child: ColoredBox(color: color, child: child),
    );
  }
}
