import 'dart:developer';

import 'package:blog_app/src/lib/features/media/presentation/logic/reproductor_de_video_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../../app/presentation/widgets/colored_icon_button.dart';

class ControlesDeReproductorDeVideo extends StatelessWidget {
  const ControlesDeReproductorDeVideo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = context.read<ReproductorDeVideoController>();
    return IconTheme(
      data: const IconThemeData(color: Colors.white),
      child: SizedBox.expand(
        child: Obx(
          () => AnimatedOpacity(
            opacity: controller.mostrar_controles.value ? 1 : 0,
            duration: const Duration(milliseconds: 700),
            child: ColoredBox(
              color: Colors.black.withOpacity(0.3),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: controller.switchControlers,
                    ),
                  ),
                  if (controller.mostrar_controles.value)
                    const ControlesDeReproductor(),
                ],
              ),
            ),
          ),
        ),
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
    return const Stack(
      children: [
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Stack(
              children: [
                ColoredBox(color: Colors.redAccent),
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
        ),
      ],
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
    return Obx(
      () => IconButtonReproductor(
        onPressed: () => context.read<ReproductorDeVideoController>().play(),
        size: 60,
        icon: _buildIcon(context),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    if (context.read<ReproductorDeVideoController>().reproduccion.value ==
        EstadoDeReproduccion.finalizado) {
      return const Icon(
        Icons.replay,
      );
    }

    if (context.read<ReproductorDeVideoController>().reproduccion.value ==
        EstadoDeReproduccion.buffering) {
      return const CircularProgressIndicator();
    }

    if (context.read<ReproductorDeVideoController>().reproduccion.value ==
        EstadoDeReproduccion.reproduciendo) {
      return const Icon(Icons.pause);
    }

    return const Icon(Icons.play_arrow);
  }
}

class _FullscreenButton extends IconButtonReproductor {
  const _FullscreenButton({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IconButtonReproductor(
        size: 45,
        icon:
            context.read<ReproductorDeVideoController>().pantalla_completa.value
                ? const Icon(
                    Icons.fullscreen,
                  )
                : const Icon(
                    Icons.fullscreen_exit,
                  ),
        onPressed: () => context.read<ChewieController>().toggleFullScreen(),
      ),
    );
  }
}

class _VolumenButton extends IconButtonReproductor {
  const _VolumenButton() : super._();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IconButtonReproductor(
        size: 45,
        onPressed: () =>
            context.read<ReproductorDeVideoController>().onVolumenPressed(),
        icon: Icon(
          context.read<ReproductorDeVideoController>().volumen.value != -1
              ? (context.read<ReproductorDeVideoController>().volumen.value == 0
                  ? Icons.volume_mute
                  : Icons.volume_up)
              : Icons.volume_off,
        ),
      ),
    );
  }
}
