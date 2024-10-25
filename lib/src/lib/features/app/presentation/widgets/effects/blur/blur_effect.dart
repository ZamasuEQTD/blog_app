import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlurEffect extends StatelessWidget {
  final bool blurear;
  final Widget? child;
  const BlurEffect({super.key, this.blurear = true, this.child});

  @override
  Widget build(BuildContext context) {
    Widget child = this.child ?? const SizedBox();

    if (blurear) {
      child = ClipRRect(
        clipBehavior: Clip.antiAlias,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 15,
          ),
          child: child,
        ),
      );
    }

    return child;
  }
}
