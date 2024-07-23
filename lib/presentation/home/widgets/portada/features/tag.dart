import 'package:flutter/material.dart';

class TagDecoration {
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final EdgeInsets padding;
  const TagDecoration(
      {this.padding = const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      this.border,
      this.backgroundColor,
      this.borderRadius});
}

class RoundedTagDecoration extends TagDecoration {
  RoundedTagDecoration(
      {super.backgroundColor, super.padding, super.border, double radius = 10})
      : super(borderRadius: BorderRadius.circular(radius));
}

class TextTagDecoration {
  final TextStyle textStyle;
  final TagDecoration decoration;

  const TextTagDecoration(
      {this.textStyle = const TextStyle(),
      this.decoration = const TagDecoration()});
}

class CustomTag extends StatelessWidget {
  final TagDecoration decoration;
  final Widget child;
  const CustomTag({
    super.key,
    this.decoration = const TagDecoration(),
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: decoration.padding,
        decoration: BoxDecoration(
            color: decoration.backgroundColor,
            borderRadius: decoration.borderRadius,
            border: decoration.border),
        child: child);
  }
}

class TextTag extends CustomTag {
  TextTag(String text,
      {super.key, TextTagDecoration decoration = const TextTagDecoration()})
      : super(
            decoration: decoration.decoration,
            child: FittedBox(
                child: Text(text,
                    style: decoration.textStyle
                        .copyWith(fontWeight: FontWeight.bold))));
}
