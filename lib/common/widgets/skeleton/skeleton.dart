import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;

  const Skeleton({super.key, this.width, this.height, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Colors.red,
      ),
      height: height,
      width: width,
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
