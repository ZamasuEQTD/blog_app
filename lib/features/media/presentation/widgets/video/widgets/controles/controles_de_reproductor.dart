import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../logic/controller/video_controller.dart';
import 'control/control.dart';

class ControlesDeReproductorLayout extends StatelessWidget {
  const ControlesDeReproductorLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = context.read<VideoController>();
    return Obx(
      () => IconTheme(
        data: const IconThemeData(color: Colors.white),
        child: SizedBox.expand(
          child: AnimatedOpacity(
            opacity: controller.mostrarControles.value ? 1 : 0,
            duration: const Duration(milliseconds: 700),
            child: ColoredBox(
              color: Colors.black.withOpacity(0.3),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: controller.toggleControles,
                    ),
                  ),
                  if (controller.mostrarControles.value)
                    const ControlesDeReproductor(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ControlesDeReproductor extends StatelessWidget {
  const ControlesDeReproductor({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Center(
            child: IconButtonReproductor.play(),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Row(
              children: [
                IconButtonReproductor.fullscreen(),
                SizedBox(width: 8),
                IconButtonReproductor.volumen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
