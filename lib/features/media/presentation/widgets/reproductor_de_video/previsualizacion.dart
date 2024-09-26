import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/reproductor/reproductor_de_video_bloc.dart';
import 'controles/widgets/control/reproductor_control_icon.dart';

class PrevisualizacionDeVideo extends StatelessWidget {
  final ImageProvider previsualizacion;
  final void Function() init;

  const PrevisualizacionDeVideo(
      {super.key, required this.previsualizacion, required this.init});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: previsualizacion),
        Positioned.fill(
            child: Align(
                alignment: Alignment.center,
                child: BlocBuilder<ReproductorDeVideoBloc,
                    ReproductorDeVideoState>(
                  builder: _builder,
                )))
      ],
    );
  }

  Widget _builder(BuildContext context, ReproductorDeVideoState state) {
    if (state.reproductor == EstadoDeReproductor.iniciando) {
      return ReproductorDeVideoControl(
        size: 50,
        icon: const CircularProgressIndicator(color: Colors.white),
        onTap: () {},
      );
    }
    return ReproductorDeVideoControl.icon(
      size: 50,
      icon: Icons.play_arrow,
      onTap: init,
    );
  }
}
