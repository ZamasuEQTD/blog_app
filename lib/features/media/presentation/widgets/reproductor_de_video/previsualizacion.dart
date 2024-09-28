import 'package:blog_app/features/media/presentation/widgets/reproductor_de_video/controles/controles_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/reproductor/reproductor_de_video_bloc.dart';

class PrevisualizacionDeVideo extends StatelessWidget {
  final ImageProvider previsualizacion;
  final void Function() init;

  const PrevisualizacionDeVideo({
    super.key,
    required this.previsualizacion,
    required this.init,
  });

  @override
  Widget build(BuildContext context) {
    Widget builder(BuildContext context, ReproductorDeVideoState state) {
      return ReproductorIconButton(
        size: 60,
        onTap: () {
          if (state.reproductor == EstadoDeReproductor.inicial) {
            init();
          }
        },
        child: state.reproductor == EstadoDeReproductor.iniciando
            ? const CircularProgressIndicator()
            : const Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
      );
    }

    return Stack(
      children: [
        Image(image: previsualizacion),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: BlocBuilder<ReproductorDeVideoBloc, ReproductorDeVideoState>(
              builder: builder,
            ),
          ),
        )
      ],
    );
  }
}
