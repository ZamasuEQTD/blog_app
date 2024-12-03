import 'package:blog_app/features/app/presentation/widgets/colored_icon_button.dart';
import 'package:blog_app/features/media/presentation/widgets/video/logic/controller/video_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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
        onPressed: () => context.read<VideoController>().play(),
        size: 60,
        icon: _buildIcon(context),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    if (context.read<VideoController>().finalizado) {
      return const Icon(
        Icons.replay,
      );
    }

    if (context.read<VideoController>().buffering) {
      return const CircularProgressIndicator();
    }

    if (context.read<VideoController>().reproduciendo) {
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
        icon: context.read<VideoController>().pantallaCompleta.value
            ? const Icon(
                Icons.fullscreen,
              )
            : const Icon(
                Icons.fullscreen_exit,
              ),
        onPressed: () => context.read<VideoController>().toggleFullScreen(),
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
        onPressed: () {
          VideoController controller = context.read<VideoController>();
          if (controller.volumen.value == 0) {
            controller.volumen.value = 1;
          } else {
            controller.volumen.value = 0;
          }
        },
        icon: Icon(
          context.read<VideoController>().volumen.value != -1
              ? (context.read<VideoController>().volumen.value == 0
                  ? Icons.volume_mute
                  : Icons.volume_up)
              : Icons.volume_off,
        ),
      ),
    );
  }
}
