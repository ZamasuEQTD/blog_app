import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../logic/controller/video_controller.dart';
import 'controles/control/control.dart';

class Previsualizacion extends StatelessWidget {
  final ImageProvider previsualizacion;

  const Previsualizacion({
    super.key,
    required this.previsualizacion,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: previsualizacion),
        const Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: IconButtonReproductor.inicializar(),
          ),
        ),
      ],
    );
  }
}
