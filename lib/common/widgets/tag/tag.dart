import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final Widget child;
  final Color background;
  final double? height;
  final BorderRadiusGeometry? border;
  final EdgeInsets? padding;

  const Tag({
    super.key,
    required this.child,
    required this.background,
    this.border,
    this.height,
    this.padding,
  });

  factory Tag.text({
    required Widget child,
    required Color background,
    BorderRadiusGeometry? border,
    EdgeInsets? padding,
  }) {
    return Tag(
      background: background,
      border: border,
      padding: padding,
      child: FittedBox(child: child),
    );
  }

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
      borderRadius: border ?? BorderRadius.circular(5),
      child: ColoredBox(
        color: background,
        child: SizedBox(
          height: height,
          child: child,
        ),
      ),
    );
  }
}
