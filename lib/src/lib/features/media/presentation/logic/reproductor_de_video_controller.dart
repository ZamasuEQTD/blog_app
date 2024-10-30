import 'dart:async';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ReproductorDeVideoController extends GetxController {
  Rx<EstadoDeReproductor> reproductor = Rx(EstadoDeReproductor.iniciado);

  Rx<double?> aspectRatio = Rx(null);
  Rx<bool> reproduciendo = Rx(false);
  Rx<bool> buffering = Rx(false);
  Rx<bool> pantalla_completa = Rx(false);
  Rx<bool> mostrar_controles = Rx(false);
  Rx<bool> finalizado = Rx(false);
  Rx<Duration> position = Rx(Duration.zero);
  Rx<double> volumen = Rx(0);

  Timer? timer;

  ReproductorDeVideoController();

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

  void switchControlers() => mostrar_controles.value = !mostrar_controles.value;
}

enum EstadoDeReproductor {
  initial,
  iniciando,
  iniciado,
}
