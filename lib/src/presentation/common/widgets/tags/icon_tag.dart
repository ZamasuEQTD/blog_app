import 'package:flutter/material.dart';

class IconTag extends StatelessWidget {
  final double height;
  final double width;
  final IconData icon;
  final Color color;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  const IconTag(
      {super.key,
      required this.icon,
      required this.color,
      this.border,
      this.borderRadius,
      required this.height,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
          border: border,
          color: color,
          borderRadius: borderRadius ?? BorderRadius.circular(3)),
      child: FittedBox(
        child: Icon(icon),
      ),
    );
  }
}
