import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController
    with
        ControlesDeReproductor,
        ReproductorStatusMixin,
        ReproduccionStatusMixin,
        FullScreenMixin {
  VideoController(ChewieController chewie) {
    this.chewie = chewie;
    controller = chewie.videoPlayerController;
  }

  Rx<Duration> position = Rx(Duration.zero);

  Rx<double> volumen = Rx(0);

  bool get isMute => volumen.value == 0;

  bool get isVolumenHabilitado => volumen.value != -1;
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

  void toggleControles() => mostrarControles.value = !mostrarControles.value;
}

mixin ReproductorStatusMixin on GetxController {
  late final VideoPlayerController controller;

  Rx<double?> aspectRatio = Rx(null);

  final Rx<ReproductorStatus> reproductorStatus = Rx(ReproductorStatus.initial);

  bool get isInitial => reproductorStatus.value == ReproductorStatus.initial;

  bool get isIniciado => reproductorStatus.value == ReproductorStatus.iniciado;

  bool get isBuffering =>
      reproductorStatus.value == ReproductorStatus.buffering;

  bool get isIniciando =>
      reproductorStatus.value == ReproductorStatus.iniciando;

  void init() async {
    reproductorStatus.value = ReproductorStatus.iniciando;

    await controller.initialize();

    aspectRatio.value = controller.value.aspectRatio;

    reproductorStatus.value = ReproductorStatus.iniciado;
  }
}

enum ReproductorStatus {
  initial,
  iniciando,
  buffering,
  iniciado,
}

mixin ReproduccionStatusMixin on GetxController {
  late final VideoPlayerController controller;

  Rx<bool> finalizado = false.obs;

  Rx<ReproduccionStatus> reproduccionStatus = Rx(ReproduccionStatus.pausado);

  bool get isPausado => reproduccionStatus.value == ReproduccionStatus.pausado;

  bool get isReproduciendo =>
      reproduccionStatus.value == ReproduccionStatus.reproduciendo;

  bool get isFinalizado => finalizado.value;

  bool get isBuffering =>
      reproduccionStatus.value == ReproduccionStatus.buffering;

  void play() async {
    await controller.play();

    reproduccionStatus.value = ReproduccionStatus.reproduciendo;
  }

  void pause() async {
    await controller.pause();

    reproduccionStatus.value = ReproduccionStatus.pausado;
  }
}

enum ReproduccionStatus {
  buffering,
  pausado,
  reproduciendo,
}

mixin FullScreenMixin on GetxController {
  late final ChewieController chewie;

  Rx<bool> pantallaCompleta = Rx(false);

  bool get isPantallaCompleta => pantallaCompleta.value;

  void toggleFullScreen() {
    chewie.toggleFullScreen();

    pantallaCompleta.value = chewie.isFullScreen;
  }
}
