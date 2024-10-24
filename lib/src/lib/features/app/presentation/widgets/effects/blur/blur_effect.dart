import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class BlurController extends ChangeNotifier {
  bool blureando;

  BlurController([this.blureando = true]);

  void blurear() {
    blureando = !blureando;
    notifyListeners();
  }
}

class BlurEffect extends StatefulWidget {
  final bool blurear;
  final BlurController? controller;
  final Widget Function(Widget child, BlurController controller)? builder;
  final Widget? child;

  const BlurEffect({
    super.key,
    this.child,
    this.builder,
    this.controller,
    this.blurear = true,
  });

  @override
  State<BlurEffect> createState() => BlurEffectState();
}

class BlurEffectState extends State<BlurEffect> {
  late final BlurController controller =
      widget.controller ?? BlurController(widget.blurear);

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child ?? const SizedBox();

    if (controller.blureando) {
      child = ClipRRect(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20,
            sigmaY: 15,
          ),
          child: child,
        ),
      );
    }

    return widget.builder == null
        ? child
        : ChangeNotifierProvider.value(
            value: controller,
            builder: (context, child) => widget.builder!(
              child!,
              context.read<BlurController>(),
            ),
            child: child,
          );
  }
}
