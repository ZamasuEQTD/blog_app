import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BlurEffect extends StatelessWidget {
  const BlurEffect({super.key});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter:
          ImageFilter.blur(sigmaX: 15, sigmaY: 12, tileMode: TileMode.decal),
      child: const SizedBox(),
    );
  }
}

class BlurOpacityEffect extends StatelessWidget {
  final Color color;
  const BlurOpacityEffect({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BlurEffect(),
        Positioned.fill(child: SizedBox(child: ColoredBox(color: color)))
      ],
    );
  }
}
