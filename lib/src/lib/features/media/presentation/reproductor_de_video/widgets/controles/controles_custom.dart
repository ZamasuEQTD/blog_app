// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

import '../../../../../app/presentation/widgets/colored_icon_button.dart';
import '../../blocs/reproductor/reproductor_de_video_bloc.dart';

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
                ),
              ),
              const ControlesDeTiempo(),
              if (state.mostrar_controles) const ControlesDeReproductor(),
            ],
          ),
        ),
      );
    }

    return IconTheme(
      data: const IconThemeData(color: Colors.white),
      child: Container(
        color: Colors.transparent,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => context
              .read<ReproductorDeVideoBloc>()
              .add(const ToggleControls()),
          child: BlocBuilder<ReproductorDeVideoBloc, ReproductorDeVideoState>(
            builder: builder,
          ),
        ),
      ),
    );
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

    return Positioned.fill(
      child: GestureDetector(
        onDoubleTapDown: (details) {
          final RenderBox box = context.findRenderObject() as RenderBox;
          final Offset localPosition =
              box.globalToLocal(details.globalPosition);
          final width = box.size.width;

          bool ladoIzquierdo() => localPosition.dx < width / 2;

          if (ladoIzquierdo()) {
            retroceder();
          } else {
            adelantar();
          }
        },
      ),
    );
  }
}

class ControlesDeReproductor extends StatelessWidget {
  const ControlesDeReproductor({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Positioned.fill(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: IconButtonReproductor.play(),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButtonReproductor.volumen(),
                  SizedBox(
                    width: 5,
                  ),
                  IconButtonReproductor.fullscreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReproductorIconButton extends StatelessWidget {
  final void Function() onTap;
  final double size;
  final Widget child;
  const ReproductorIconButton({
    super.key,
    required this.onTap,
    required this.size,
    required this.child,
  });

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

abstract class IconButtonReproductor extends StatelessWidget {
  const IconButtonReproductor._({super.key});

  const factory IconButtonReproductor({
    Key? key,
    required double size,
    required void Function() onPressed,
    required Widget icon,
  }) = _IconButtonReproductor;

  const factory IconButtonReproductor.fullscreen() = _FullscreenButton;

  const factory IconButtonReproductor.play() = _PlayButton;

  const factory IconButtonReproductor.volumen() = _VolumenButton;

  const factory IconButtonReproductor.inicializar() = _VolumenButton;
}

class _IconButtonReproductor extends IconButtonReproductor {
  final double size;
  final void Function() onPressed;
  final Widget icon;

  const _IconButtonReproductor({
    super.key,
    required this.size,
    required this.onPressed,
    required this.icon,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: ColoredIconButton(
        background: Colors.black.withOpacity(0.3),
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}

class _PlayButton extends IconButtonReproductor {
  const _PlayButton() : super._();

  @override
  Widget build(BuildContext context) {
    return IconButtonReproductor(
      onPressed: () =>
          context.read<ReproductorDeVideoBloc>()..add(SwitchReproduccion()),
      size: 60,
      icon: const Icon(
        Icons.replay,
      ),
    );
  }
}

class _FullscreenButton extends IconButtonReproductor {
  const _FullscreenButton({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReproductorDeVideoBloc, ReproductorDeVideoState>(
      builder: (context, state) {
        return IconButtonReproductor(
          size: 45,
          onPressed: () => !state.pantalla_completa
              ? context.read<ChewieController>().enterFullScreen()
              : context.read<ChewieController>().exitFullScreen(),
          icon: !state.pantalla_completa
              ? const Icon(
                  Icons.fullscreen,
                )
              : const Icon(
                  Icons.fullscreen_exit,
                ),
        );
      },
    );
  }
}

class _VolumenButton extends IconButtonReproductor {
  const _VolumenButton() : super._();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReproductorDeVideoBloc, ReproductorDeVideoState>(
      builder: (context, state) {
        return IconButtonReproductor(
          size: 45,
          onPressed: () => context
              .read<VideoPlayerController>()
              .setVolume(state.volumen == 0 ? 1 : 0),
          icon: BlocBuilder<ReproductorDeVideoBloc, ReproductorDeVideoState>(
            builder: (context, state) {
              return Icon(
                state.volumen != -1
                    ? (state.volumen == 0 ? Icons.volume_mute : Icons.volume_up)
                    : Icons.volume_off,
              );
            },
          ),
        );
      },
    );
  }
}

abstract class ReproductorDeVideoButton extends StatelessWidget {
  const ReproductorDeVideoButton({super.key});
}

class _ReproductorDeVideoButton {}
