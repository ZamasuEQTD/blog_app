import 'package:flutter/material.dart';
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
