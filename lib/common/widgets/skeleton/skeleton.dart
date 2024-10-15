import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final Widget? child;
  final BorderRadiusGeometry? borderRadius;

  const Skeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.color,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        color: color ?? const Color(0xfff2f2f2),
      ),
      height: height,
      width: width,
      child: child,
    );
  }
}

class CircleSkeleton extends Skeleton {
  const CircleSkeleton({super.key, required double size})
      : super(height: size, width: size);

  @override
  Widget build(BuildContext context) {
    return ClipOval(child: super.build(context));
  }
}

class SkeletonBackground extends StatelessWidget {
  const SkeletonBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return const Skeleton(
      color: Color(0xffDEE2E6),
    );
  }
}
