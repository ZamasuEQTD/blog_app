import 'package:blog_app/features/media/presentation/logic/bloc/reproductor/reproductor_de_video_bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/control/reproductor_control_icon.dart';

class ControlesDeReproductorDeVideo extends StatelessWidget {
  const ControlesDeReproductorDeVideo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget builder(BuildContext context, ReproductorDeVideoState state) {
      return AnimatedOpacity(
        opacity: state.controles == EstadoDeControles.mostrar ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: IgnorePointer(
          ignoring: state.controles == EstadoDeControles.ocultos,
          child: Container(
            color: Colors.black.withOpacity(0.3),
            child: const Stack(
              children: [ControlesDeReproduccion()],
            ),
          ),
        ),
      );
    }

    return Container(
        color: Colors.transparent,
        child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => context
                .read<ReproductorDeVideoBloc>()
                .add(const ToggleControls()),
            child: BlocBuilder<ReproductorDeVideoBloc, ReproductorDeVideoState>(
              builder: builder,
            )));
  }
}

class ControlesDeReproduccion extends StatefulWidget {
  const ControlesDeReproduccion({
    super.key,
  });

  @override
  State<ControlesDeReproduccion> createState() =>
      _ControlesDeReproduccionState();
}

class _ControlesDeReproduccionState extends State<ControlesDeReproduccion> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ChewieController controller = context.read();

    return Positioned.fill(
        child: Stack(
      children: [
        Center(
            child: ReproductorDeVideoControl(
          icon: BlocBuilder<ReproductorDeVideoBloc, ReproductorDeVideoState>(
            builder: (context, state) {
              if (state.reproduccion == EstadoDeReproduccion.pausado) {
                return const Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 40,
                );
              }
              return const Icon(
                Icons.pause,
                color: Colors.white,
                size: 40,
              );
            },
          ),
          size: 65,
          onTap: () {
            controller.play();
          },
        ))
      ],
    ));
  }
}

class ControlesDeTiempo extends StatelessWidget {
  final ChewieController controller;
  const ControlesDeTiempo({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    ChewieController controller = context.read();

    void retroceder() {
      controller.retroceder(const Duration(seconds: 10));
    }

    void adelantar() {
      controller.adelantar(const Duration(seconds: 10));
    }

    return Positioned.fill(
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onDoubleTap: retroceder,
            ),
          ),
          Expanded(
              child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onDoubleTap: adelantar,
          ))
        ],
      ),
    );
  }
}
