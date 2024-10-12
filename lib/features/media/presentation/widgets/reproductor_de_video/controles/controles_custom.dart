import 'dart:developer';

import 'package:blog_app/common/widgets/button/filled_icon_button.dart';
import 'package:blog_app/features/media/presentation/logic/bloc/reproductor/reproductor_de_video_bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class ControlesDeReproductorDeVideo extends StatelessWidget {
  const ControlesDeReproductorDeVideo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget builder(BuildContext context, ReproductorDeVideoState state) {
      return AnimatedOpacity(
        opacity: state.mostrar_controles ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: ColoredBox(
          color: Colors.black.withOpacity(0.3),
          child: Stack(
            children: [
              Positioned.fill(
                  child: GestureDetector(
                onTap: () => context
                    .read<ReproductorDeVideoBloc>()
                    .add(const ToggleControls()),
              )),
              const ControlesDeTiempo(),
              if (state.mostrar_controles) const ControlesDeReproductor(),
            ],
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

class ControlesDeTiempo extends StatelessWidget {
  const ControlesDeTiempo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    VideoPlayerController controller = context.read();

    void retroceder() {
      controller.retroceder(const Duration(seconds: 10));
    }

    void adelantar() {
      controller.adelantar(const Duration(seconds: 10));
    }

    return Positioned.fill(child: GestureDetector(
      onDoubleTapDown: (details) {
        final RenderBox box = context.findRenderObject() as RenderBox;
        final Offset localPosition = box.globalToLocal(details.globalPosition);
        final width = box.size.width;

        bool ladoIzquierdo() => localPosition.dx < width / 2;

        if (ladoIzquierdo()) {
          retroceder();
        } else {
          adelantar();
        }
      },
    ));
  }
}

class ControlesDeReproductor extends StatelessWidget {
  const ControlesDeReproductor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Widget builder(BuildContext context, ReproductorDeVideoState state) {
      Widget playIcon() {
        if (state.finalizado) {
          return const Icon(
            Icons.replay,
            color: Colors.white,
          );
        }

        if (state.buffering) {
          return const CircularProgressIndicator();
        }

        if (state.reproduciendo) {
          return const Icon(
            Icons.pause,
            color: Colors.white,
          );
        }

        return const Icon(
          Icons.play_arrow,
          color: Colors.white,
        );
      }

      return Positioned.fill(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ReproductorIconButton(
                size: 60,
                onTap: () {
                  if (state.reproduciendo) {
                    context.read<ChewieController>().pause();
                  } else {
                    context.read<ChewieController>().play();
                  }
                },
                child: playIcon(),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ReproductorIconButton(
                    onTap: () => context
                        .read<VideoPlayerController>()
                        .setVolume(state.volumen == 0 ? 1 : 0),
                    size: 45,
                    child: Icon(
                      state.volumen != -1
                          ? (state.volumen == 0
                              ? Icons.volume_mute
                              : Icons.volume_up)
                          : Icons.volume_off,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 5),
                  ReproductorIconButton(
                    onTap: () => !state.pantalla_completa
                        ? context.read<ChewieController>().enterFullScreen()
                        : context.read<ChewieController>().exitFullScreen(),
                    size: 45,
                    child: Icon(
                      state.pantalla_completa
                          ? Icons.fullscreen_exit
                          : Icons.fullscreen,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ));
    }

    return BlocBuilder<ReproductorDeVideoBloc, ReproductorDeVideoState>(
      builder: builder,
    );
  }
}

class ReproductorIconButton extends StatelessWidget {
  final void Function() onTap;
  final double size;
  final Widget child;
  const ReproductorIconButton(
      {super.key,
      required this.onTap,
      required this.size,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: ColoredIconButton(
        background: Colors.black.withOpacity(0.3),
        onPressed: onTap,
        icon: SizedBox(
          height: size,
          width: size,
          child: FittedBox(
            child: child,
          ),
        ),
      ),
    );
  }
}