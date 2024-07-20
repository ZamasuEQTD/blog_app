import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  final double? height;
  final double? width;
  final Color color;
  final BorderRadiusGeometry? borderRadius;
  const Skeleton({
    super.key,
    this.height,
    this.width,
    this.color = const Color.fromRGBO(199, 199, 199, 1),
    this.borderRadius
  });

  const Skeleton.white({super.key,
      this.height,
      this.width,
      this.color = Colors.white,
      this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        color: color,
      ),
      height: height,
      width: width,
    );
  }
}

class CircleLoadingWidget extends StatelessWidget {
  final double size;
  const CircleLoadingWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle, color: Color.fromRGBO(199, 199, 199, 1)
      ),
    );
  }
}
