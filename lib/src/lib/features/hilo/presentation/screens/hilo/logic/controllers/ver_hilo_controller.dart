import 'dart:async';
import 'dart:collection';

import 'package:blog_app/src/lib/features/app/domain/models/spoileable.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/icomentarios_repository.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/comentario.dart';
import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:blog_app/src/lib/features/media/domain/models/media.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../../../domain/models/hilo.dart';

class HiloController extends GetxController {
  final String id;

  Rx<Failure?> failure = Rx(null);
  Rx<bool> cargando = false.obs;

  Rx<Hilo?> hilo = Rx(null);

  DateTime? ultimoComentario;

  Rx<String?> taggueo = Rx(null);

  Rx<bool> cargandoComentarios = false.obs;

  Rx<HashMap<String, List<String>>> taggueosComentarios = Rx(HashMap());

  Rx<List<Comentario>> comentarios = Rx([]);

  Rx<Comentario?> ultimoComentarioAgregado = Rx(null);

  Rx<EnvioComentarioState> envioComentario = EnvioComentarioState.initial.obs;
  Rx<String> comentario = "".obs;
  Rx<Spoileable<Media>?> media = Rx(null);
  List<String> taggueos = [];

  Rx<double> bottom = 0.0.obs;

  HiloController({required this.id});

  Future<void> cargar() async {
    cargando.value = true;

    IHilosRepository repository = GetIt.I.get();

    var result = await repository.getHilo(id: id);

    result.fold(
      (l) {
        failure.value = l;
      },
      (r) {
        hilo.value = r;
      },
    );

    cargando.value = false;
  }

  Future<void> cargarComentarios() async {
    IComentariosRepository repository = GetIt.I.get();

    var result = await repository.getComentarios(
      hilo: hilo.value!.id,
      ultimoComentario: ultimoComentario,
    );

    result.fold(
      (l) {
        failure.value = l;
      },
      (r) {
        for (var c in r) {
          ultimoComentarioAgregado.value = c;
        }

        if (r.isNotEmpty) {
          ultimoComentario = r.last.creado_en;
        }

        comentarios.value = [...comentarios.value, ...r];
      },
    );
  }

  Future<void> enviarComentario() async {
    if (envioComentario.value == EnvioComentarioState.enviando) return;

    envioComentario.value = EnvioComentarioState.enviando;
    IComentariosRepository repository = GetIt.I.get();

    var result = await repository.enviar(
      hilo: hilo.value!.id,
      comentario: comentario.value,
    );

    result.fold(
      (l) {
        failure.value = l;
      },
      (r) {
        envioComentario.value = EnvioComentarioState.enviado;
      },
    );

    envioComentario.value = EnvioComentarioState.initial;
  }

  void tagguear(String tag) {
    if (taggueos.contains(tag)) {
      return;
    }
    if (taggueos.length > 5) {
      return;
    }

    taggueo.value = tag;

    taggueos.add(tag);
  }

  void agregarMedia(Media media) {
    this.media.value = Spoileable(false, media);
  }

  void eliminarMedia() {
    media.value = null;

    media.refresh();
  }
}

enum EnvioComentarioState {
  initial,
  enviando,
  enviado,
  error,
}
