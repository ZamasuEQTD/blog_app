// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// class BlurEffect extends StatelessWidget {
//   final bool blurear;
//   final Widget? child;
//   const BlurEffect({super.key, this.blurear = true, this.child});

//   @override
//   Widget build(BuildContext context) {
//     Widget child = this.child ?? const SizedBox();

//     if (blurear) {
//       child = ClipRRect(
//         clipBehavior: Clip.antiAlias,
//         child: BackdropFilter(
//           filter: ImageFilter.blur(
//             sigmaX: 20,
//             sigmaY: 15,
//           ),
//           child: child,
//         ),
//       );
//     }

//     return child;
//   }
// }

typedef BlurEffectBuilder = Widget Function(
  BlurController controller,
  Widget blur,
);

abstract class BlurEffect extends StatelessWidget {
  const BlurEffect._({super.key});

  const factory BlurEffect({
    required bool blurear,
    Widget? child,
  }) = _BlurEffect;

  const factory BlurEffect.builder({
    Key? key,
    required BlurEffect blur,
    required BlurEffectBuilder builder,
    required Widget child,
  }) = _BlurEffectBuilder;
}

class _BlurEffect extends BlurEffect {
  final bool blurear;
  final Widget? child;
  const _BlurEffect({
    required this.blurear,
    this.child,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    Widget child = this.child ?? const SizedBox();
    if (blurear) {
      child = ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 30,
            sigmaY: 25,
            tileMode: TileMode.clamp,
          ),
          child: child,
        ),
      );
    }
    return child;
  }
}

class _BlurEffectBuilder extends BlurEffect {
  final Widget child;
  final BlurEffect blur;
  final BlurEffectBuilder builder;

  const _BlurEffectBuilder({
    super.key,
    required this.builder,
    required this.child,
    required this.blur,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: BlurController(),
      builder: (controller) => Stack(
        children: [
          child,
          if (controller.blurear.value) builder(controller, blur),
        ],
      ),
    );
  }
}

class BlurController extends GetxController {
  RxBool blurear = RxBool(true);
}
