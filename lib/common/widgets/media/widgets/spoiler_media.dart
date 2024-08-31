import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../effects/blur/blurear_widget.dart';

class MediaSpoileable extends StatelessWidget {
  final Widget child;
  const MediaSpoileable({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlurBuilder(
        builder: (context, child, controller) {
          return Stack(
            children: [
              child,
              controller.blurear
                  ? Positioned.fill(
                      child: Center(
                      child: _VerContenidoButton(
                        controller: controller,
                      ),
                    ))
                  : const SizedBox()
            ],
          );
        },
        child: child);
  }
}

class _VerContenidoButton extends StatelessWidget {
  final BlurController controller;
  const _VerContenidoButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () => controller.switchBlur(),
        style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(Colors.white.withOpacity(0.15)),
            side: const WidgetStatePropertyAll(
                BorderSide(width: 0.5, color: Colors.transparent)),
            shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)))),
            padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(vertical: 20, horizontal: 30))),
        child: const Text(
          "Ver contenido",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ));
  }
}
