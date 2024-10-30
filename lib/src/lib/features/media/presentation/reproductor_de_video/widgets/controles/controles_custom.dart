import 'package:blog_app/src/lib/features/media/presentation/logic/reproductor_de_video_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/presentation/widgets/colored_icon_button.dart';

class ControlesDeReproductorDeVideo extends StatelessWidget {
  const ControlesDeReproductorDeVideo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: const IconThemeData(color: Colors.white),
      child: Container(
        color: Colors.transparent,
        child: AnimatedOpacity(
          opacity: 1,
          duration: const Duration(milliseconds: 500),
          child: ColoredBox(
            color: Colors.black.withOpacity(0.3),
            child: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(),
                ),
                Positioned.fill(
                  child: Row(
                    children: [
                      Expanded(child: GestureDetector()),
                      Expanded(child: GestureDetector()),
                    ],
                  ),
                ),
                if (true) const ControlesDeReproductor(),
              ],
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
  const VideoControllerProvider({
    super.key,
    required this.controller,
    required super.child,
  });

  static VideoControllerProvider? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<VideoControllerProvider>();

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
