import 'dart:async';

import 'package:get/get.dart';

class VideoController extends GetxController with ControlesDeReproductor {
  Rx<double?> aspectRatio = Rx(null);
  Rx<Duration> position = Rx(Duration.zero);
  Rx<double> volumen = Rx(0);
  Rx<bool> pantallaCompleta = Rx(false);

  Rx<ReproductorStatus> reproductorStatus = Rx(ReproductorStatus.initial);

  Rx<ReproduccionStatus> reproduccionStatus = Rx(ReproduccionStatus.pausado);

  bool get finalizado =>
      reproduccionStatus.value == ReproduccionStatus.finalizado;

  bool get buffering =>
      reproduccionStatus.value == ReproduccionStatus.buffering;

  bool get reproduciendo =>
      reproduccionStatus.value == ReproduccionStatus.reproduciendo;

  void toggleFullScreen() => pantallaCompleta.value = !pantallaCompleta.value;

  void play() => reproduccionStatus.value = ReproduccionStatus.reproduciendo;
}

enum ReproductorStatus {
  initial,
  iniciando,
  iniciado,
}

enum ReproduccionStatus {
  buffering,
  pausado,
  reproduciendo,
  finalizado,
}

mixin ControlesDeReproductor on GetxController {
  static const Duration duracion = Duration(seconds: 3);

  Rx<bool> mostrarControles = false.obs;

  Timer? timer;

  @override
  void onInit() {
    mostrarControles.listen((mostrar) {
      if (mostrar) {
        timer = Timer(
          duracion,
          () {
            mostrarControles.value = false;
          },
        );
      } else {
        if (timer?.isActive ?? false) timer?.cancel();
      }
    });

    super.onInit();
  }
}
