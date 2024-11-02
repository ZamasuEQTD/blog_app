import 'package:get/get.dart';

import '../domain/models/encuesta.dart';

class EncuestaController extends GetxController {
  late final Rx<Encuesta> encuesta;

  final Rx<RespuestaId?> seleccionada = Rx<RespuestaId?>(null);

  EncuestaController({required Encuesta encuesta}) {
    this.encuesta = Rx<Encuesta>(encuesta);
  }

  void votar() {
    if (seleccionada.value == null) return;
    sumarVoto(seleccionada.value!);
  }

  void sumarVoto(RespuestaId id) {
    encuesta.value = encuesta.value.copyWith(
      votos: encuesta.value.votos + 1,
      respuestas: encuesta.value.respuestas
          .map((r) => r.id == id ? r.copyWith(votos: r.votos + 1) : r)
          .toList(),
    );
  }

  void seleccionar(RespuestaId id) {
    if (encuesta.value.respuesta != null) return;

    if (seleccionada.value == id) {
      seleccionada.value = null;
    } else {
      seleccionada.value = id;
    }
  }
}
