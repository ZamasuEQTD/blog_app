import 'package:flutter/material.dart';
import 'blur_effect.dart';

class BlurearWidget extends StatelessWidget {
  final Widget child;
  const BlurearWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Stack(
        children: [
          child,
          Positioned.fill(child: BlurOpacityEffect(color: Colors.black.withOpacity(0.6))),
        ],
      ),
    );
  }
}


class SobreBlur extends StatelessWidget {
  final Widget child;
  const SobreBlur({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(child: BlurearWidget(child: SizedBox())),
        child
      ],
    );



    
  }
}