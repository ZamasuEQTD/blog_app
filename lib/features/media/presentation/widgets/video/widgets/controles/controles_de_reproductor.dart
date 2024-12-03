import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../logic/controller/video_controller.dart';

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
                      onTap: () => controller.mostrarControles.value =
                          !controller.mostrarControles.value,
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
    return Container();
  }
}
