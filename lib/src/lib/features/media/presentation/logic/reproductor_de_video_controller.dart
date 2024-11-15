import 'dart:async';

import 'package:blog_app/src/lib/features/app/presentation/extensions/video_player_controller.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ReproductorDeVideoController extends GetxController {
  VideoPlayerController controller;

  Rx<EstadoDeReproductor> reproductor = Rx(EstadoDeReproductor.iniciado);

  Rx<double?> aspectRatio = Rx(null);

  Rx<bool> pantalla_completa = Rx(false);

  Rx<bool> mostrar_controles = Rx(false);

  Rx<Duration> position = Rx(Duration.zero);

  Rx<double> volumen = Rx(0);

  Timer? timer;

  Rx<EstadoDeReproduccion> reproduccion = Rx(EstadoDeReproduccion.pausado);

  ReproductorDeVideoController(this.controller);

  @override
  void onInit() {
    super.onInit();

    mostrar_controles.listen((mostrar) {
      if (mostrar) {
        timer = Timer(
          const Duration(seconds: 4),
          () {
            mostrar_controles.value = false;
          },
        );
      } else {
        if (timer?.isActive ?? false) timer?.cancel();
      }
    });
  }

  void iniciar(VideoPlayerController controller) async {
    reproductor.value = EstadoDeReproductor.iniciando;
    try {
      await controller.initialize();
      aspectRatio.value = controller.value.aspectRatio;
      reproductor.value = EstadoDeReproductor.iniciado;
    } catch (e) {}
  }

  void play() async {
    if (controller.value.duration == controller.value.position) {
      await controller.replay();
    } else {
      if (controller.value.isPlaying) {
        await controller.pause();
      } else {
        await controller.play();
      }
    }
  }

  void onVolumenPressed() {
    controller.setVolume(volumen.value == 0 ? 1 : 0);
  }

  void switchControlers() => mostrar_controles.value = !mostrar_controles.value;
}

enum EstadoDeReproductor {
  initial,
  iniciando,
  iniciado,
}

enum EstadoDeReproduccion {
  buffering,
  pausado,
  reproduciendo,
  finalizado,
}
