import 'package:flutter/material.dart';

class TextFlatBtn extends StatelessWidget {
  final String txt;
  final void Function()? onTap;
  final Color? color;
  final Color backgroundColor;
  final TextStyle? textStyle;
  final double borderRadius;
  const TextFlatBtn({
    super.key,
    required this.txt,
    this.color,
    this.onTap,
    this.textStyle,
    this.backgroundColor = Colors.white,
    this.borderRadius = 20,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius)
        ),
        child: Center(
          child: Text(
            txt,
            style: TextStyle(fontWeight: FontWeight.w600, color: color)
                .merge(textStyle),
          ),
        ),
      ),
    );
  }
}
