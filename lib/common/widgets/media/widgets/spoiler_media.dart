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
                  ? const Positioned.fill(
                      child: Center(
                      child: _VerContenidoButton(),
                    ))
                  : const SizedBox()
            ],
          );
        },
        child: child);
  }
}

class _VerContenidoButton extends StatelessWidget {
  const _VerContenidoButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: () => context.read<BlurController>().switchBlur(),
        style: const ButtonStyle(
            side: WidgetStatePropertyAll(
                BorderSide(width: 0.5, color: Colors.white)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)))),
            padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(vertical: 20, horizontal: 30))),
        child: const Text(
          "Ver contenido",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ));
  }
}
