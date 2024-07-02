import 'package:flutter/material.dart';

class Tag extends StatelessWidget {
  final double height;
  final String txt;
  final Color color;
  final TextStyle? textStyle;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  const Tag(
      {super.key,
      required this.height,
      required this.txt,
      required this.color,
      this.textStyle,
      this.border,
      this.padding,
      this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: border,
          color: color,
          borderRadius: borderRadius ?? BorderRadius.circular(3)),
      height: height,
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: FittedBox(
        child: Text(
          txt,
          style:
              const TextStyle(fontWeight: FontWeight.w700, color: Colors.white)
                  .merge(textStyle),
        ),
      ),
    );
  }
}
