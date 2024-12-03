import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../logic/controller/video_controller.dart';
import 'controles/control/control.dart';

class Previsualizacion extends StatelessWidget {
  final VideoPlayerController controller;
  final ImageProvider previsualizacion;

  const Previsualizacion({
    super.key,
    required this.controller,
    required this.previsualizacion,
  });

  @override
  Widget build(BuildContext context) {
    final VideoController controller = context.read<VideoController>();
    return Obx(
      () => Stack(
        children: [
          Image(image: previsualizacion),
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: ReproductorIconButton(
                size: 60,
                onTap: () {
                  this.controller.initialize();
                },
                child: controller.reproductorStatus.value ==
                        ReproductorStatus.iniciando
                    ? const CircularProgressIndicator()
                    : const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
