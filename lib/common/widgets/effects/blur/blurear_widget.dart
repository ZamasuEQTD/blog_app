import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
          Positioned.fill(
              child: BlurOpacityEffect(color: Colors.black.withOpacity(0.6))),
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

class BlurBuilder extends StatelessWidget {
  final Widget child;
  final Widget Function(
      BuildContext context, Widget child, BlurController controller) builder;
  const BlurBuilder({super.key, required this.child, required this.builder});

  @override
  Widget build(BuildContext context) {
    final BlurController controller = BlurController();
    return Obx(() => builder(context,
        Blurear(blurear: controller.blurear, child: child), controller));
  }
}

class BlurController extends GetxController {
  final Rx<bool> _blurear = true.obs;

  bool get blurear => _blurear.value;

  void switchBlur() => _blurear.value = !blurear;
}

class Blurear extends StatelessWidget {
  final Widget child;
  final bool blurear;
  const Blurear({super.key, required this.blurear, required this.child});

  @override
  Widget build(BuildContext context) {
    return blurear ? BlurearWidget(child: child) : child;
  }
}
