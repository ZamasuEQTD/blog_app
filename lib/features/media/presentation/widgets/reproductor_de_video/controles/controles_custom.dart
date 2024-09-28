import 'dart:developer';

import 'package:blog_app/common/widgets/button/filled_icon_button.dart';
import 'package:blog_app/features/media/presentation/logic/bloc/reproductor/reproductor_de_video_bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import 'widgets/control/reproductor_control_icon.dart';

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
              if (state.mostrar_controles)
                Positioned.fill(
                    child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Stack(
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                            color: Colors.black,
                            width: 50,
                            height: 50,
                          )),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 40,
                              width: 40,
                              child: ColoredIconButton(
                                  background: Colors.black.withOpacity(0.5),
                                  onPressed: () => context
                                      .read<VideoPlayerController>()
                                      .setVolume(state.volumen == 0 ? 1 : 0),
                                  icon: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: FittedBox(
                                      child: Icon(
                                        state.volumen != -1
                                            ? (state.volumen == 0
                                                ? Icons.volume_mute
                                                : Icons.volume_up)
                                            : Icons.volume_off,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),
                            ),
                            const SizedBox(width: 5),
                            ColoredIconButton(
                                background: Colors.black.withOpacity(0.5),
                                onPressed: () => context
                                    .read<ChewieController>()
                                    .enterFullScreen(),
                                icon: const Icon(
                                  Icons.fullscreen,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                )),
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
    final VideoPlayerController controller = context.read();

    return Positioned.fill(
        child: Stack(
      children: [
        Center(
            child: BlocBuilder<ReproductorDeVideoBloc, ReproductorDeVideoState>(
          builder: (context, state) {
            Widget icon() {
              if (state.buffering) {
                return const CircularProgressIndicator();
              }

              if (state.pausado) {
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
            }

            void onTap() {
              log("holaa");
              if (state.pausado) {
                controller.play();
              } else {
                controller.pause();
              }
            }

            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: onTap,
              child: const ColoredBox(
                color: Colors.red,
                child: SizedBox(height: 100, width: 100),
              ),
            );
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
    VideoPlayerController controller = context.read();

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
