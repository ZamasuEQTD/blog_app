import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:get/get.dart';

class ReproductorDeVideoController extends GetxController {
  Rx<EstadoDeReproductor> reproductor = Rx(EstadoDeReproductor.iniciado);
  Rx<bool> reproduciendo = Rx(false);
  Rx<bool> buffering = Rx(false);
  Rx<bool> pantalla_completa = Rx(false);
  Rx<bool> mostrar_controles = Rx(false);
  Rx<bool> finalizado = Rx(false);
  Rx<Duration> position = Rx(Duration.zero);
  Rx<double> volumen = Rx(0);

  Timer? timer;

  final ChewieController controller;

  ReproductorDeVideoController({required this.controller});

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

    controller.addListener(() {
      finalizado.value = controller.videoPlayerController.value.isCompleted;
      buffering.value = controller.videoPlayerController.value.isBuffering;
      position.value = controller.videoPlayerController.value.position;
      pantalla_completa.value = controller.isFullScreen;
    });
  }

  void play() => controller.play();

  void pause() => controller.pause();

  void iniciar() async {
    reproductor.value = EstadoDeReproductor.iniciando;

    try {
      await controller.videoPlayerController.initialize();
      reproductor.value = EstadoDeReproductor.iniciado;
    } catch (e) {}
  }
}

enum EstadoDeReproductor {
  initial,
  iniciando,
  iniciado,
}
