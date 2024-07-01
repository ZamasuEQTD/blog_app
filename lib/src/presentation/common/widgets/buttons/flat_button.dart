
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FlatBtn extends StatelessWidget {
  static const double defaultBorderRadius = 20;

  final void Function()? onTap;
  final Widget child;
  final double borderRadius;
  final Color backgroundColor;
  const FlatBtn._({
    super.key, 
    required this.child, 
    required this.borderRadius, 
    Color? backgroundColor,
    this.onTap
  })
  :backgroundColor = backgroundColor??Colors.red;

  factory FlatBtn.text({
    Key? key,
    double borderRadius = defaultBorderRadius,
    void Function()? onTap,
    required String txt,
    TextStyle? textStyle,
    Color? backgroundColor
  }) {
    return FlatBtn._(
        key: key, 
        onTap: onTap, 
        borderRadius: borderRadius, 
        backgroundColor:backgroundColor, 
        child: Text(txt,style: textStyle,)
    );
  }

  factory FlatBtn({
      Key? key,
      double borderRadius = defaultBorderRadius,
      void Function()? onTap,
      required Widget child,
      Color? backgroundColor
    }) {
    return FlatBtn._(
        key: key, 
        onTap: onTap, 
        borderRadius: borderRadius,
        backgroundColor:backgroundColor, 
        child: child,
      );
  }

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
            child: child
        ),
      ),
    );
  }
}