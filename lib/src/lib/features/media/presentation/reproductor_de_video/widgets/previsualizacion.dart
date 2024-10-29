// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:blog_app/src/lib/features/media/presentation/logic/reproductor_de_video_controller.dart';

import 'controles/controles_custom.dart';

class PrevisualizacionDeVideo extends StatelessWidget {
  final ImageProvider previsualizacion;
  final EstadoDeReproductor estado;
  final void Function() init;

  const PrevisualizacionDeVideo({
    super.key,
    required this.previsualizacion,
    required this.estado,
    required this.init,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: previsualizacion),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: ReproductorIconButton(
              size: 60,
              onTap: () {
                if (estado == EstadoDeReproductor.initial) {
                  init();
                }
              },
              child: estado == EstadoDeReproductor.iniciando
                  ? const CircularProgressIndicator()
                  : const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
