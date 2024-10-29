// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:blog_app/src/lib/features/media/presentation/logic/reproductor_de_video_controller.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../../../app/presentation/widgets/colored_icon_button.dart';

class ControlesDeReproductorDeVideo extends StatelessWidget {
  const ControlesDeReproductorDeVideo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ReproductorDeVideoController controller =
        VideoControllerProvider.of(context)!.controller;

    return IconTheme(
      data: const IconThemeData(color: Colors.white),
      child: Container(
        color: Colors.transparent,
        child: AnimatedOpacity(
          opacity: controller.mostrar_controles.value ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: ColoredBox(
            color: Colors.black.withOpacity(0.3),
            child: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: () => controller.mostrar_controles.value =
                        !controller.mostrar_controles.value,
                  ),
                ),
                const ControlesDeTiempo(),
                if (controller.mostrar_controles.value)
                  const ControlesDeReproductor(),
              ],
            ),
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
    ReproductorDeVideoController controller =
        VideoControllerProvider.of(context)!.controller;

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
      onPressed: () => VideoControllerProvider.of(context)!.controller.play(),
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
    ReproductorDeVideoController controller = VideoControllerProvider.of(
      context,
    )!
        .controller;

    return Obx(
      () => IconButtonReproductor(
        size: 45,
        icon: !controller.pantalla_completa.value
            ? const Icon(
                Icons.fullscreen,
              )
            : const Icon(
                Icons.fullscreen_exit,
              ),
        onPressed: () => controller.pantalla_completa.value
            ? controller.controller.exitFullScreen
            : controller.controller.enterFullScreen,
      ),
    );
  }
}

class _VolumenButton extends IconButtonReproductor {
  const _VolumenButton() : super._();

  @override
  Widget build(BuildContext context) {
    ReproductorDeVideoController controller =
        VideoControllerProvider.of(context)!.controller;
    return Obx(
      () => IconButtonReproductor(
        size: 45,
        onPressed: () => controller.play,
        icon: Icon(
          controller.volumen.value != -1
              ? (controller.volumen.value == 0
                  ? Icons.volume_mute
                  : Icons.volume_up)
              : Icons.volume_off,
        ),
      ),
    );
  }
}

class VideoControllerProvider extends InheritedWidget {
  final ReproductorDeVideoController controller;
  const VideoControllerProvider(
    this.controller, {
    super.key,
    required super.child,
  });

  static VideoControllerProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<VideoControllerProvider>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
