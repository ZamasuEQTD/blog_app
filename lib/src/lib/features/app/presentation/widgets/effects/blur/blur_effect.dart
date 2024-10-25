// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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

abstract class BlurEffect extends StatelessWidget {
  const BlurEffect._({super.key});

  const factory BlurEffect({
    required bool blurear,
    Widget? child,
  }) = _BlurEffect;

  const factory BlurEffect.builder({
    required bool blurear,
    required Widget Function(BlurController, Widget) builder,
    Widget? child,
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

class _BlurEffectBuilder extends BlurEffect {
  final Widget Function(BlurController controller, Widget child) builder;
  final bool blurear;
  final Widget? child;

  const _BlurEffectBuilder({
    required this.builder,
    required this.blurear,
    this.child,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BlurController(),
      builder: (context, child) {
        return builder(
          context.read(),
          BlurEffect(
            blurear: context.watch<BlurController>().blurear,
          ),
        );
      },
    );
  }
}

class BlurController extends ChangeNotifier {
  bool blurear;
  BlurController({
    this.blurear = true,
  });

  void switchBlur() {
    blurear = !blurear;

    notifyListeners();
  }
}
