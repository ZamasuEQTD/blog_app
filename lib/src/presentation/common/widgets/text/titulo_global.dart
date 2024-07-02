import 'package:flutter/material.dart';

class TituloGlobal extends StatelessWidget {
  final String txt;
  final EdgeInsets? margin;
  final double? fontSize;
  final TextStyle? customStyle;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  const TituloGlobal(
      {super.key,
      required this.txt,
      this.margin,
      this.fontSize,
      this.customStyle,
      this.maxLines,
      this.overflow,
      this.fontWeight,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Text(
        txt,
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow,
        style: TextStyle(
                fontSize: fontSize ?? 20,
                fontWeight: fontWeight ?? FontWeight.w600)
            .merge(customStyle),
      ),
    );
  }
}
