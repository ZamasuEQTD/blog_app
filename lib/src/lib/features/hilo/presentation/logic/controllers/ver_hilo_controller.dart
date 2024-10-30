import 'dart:async';
import 'dart:collection';

import 'package:blog_app/src/lib/features/app/domain/models/spoileable.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/icomentarios_repository.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/comentario.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:blog_app/src/lib/features/hilo/domain/services/tag_service.dart';
import 'package:blog_app/src/lib/features/media/domain/models/media.dart';
import 'package:blog_app/src/lib/features/moderacion/domain/models/usuario.dart';
import 'package:blog_app/src/lib/features/notificaciones/presentation/logic/controles/mis_notificaciones_controller.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/models/hilo.dart';

class HiloController extends GetxController {
  final String id;

  Rx<Failure?> failure = Rx(null);
  Rx<bool> cargando = false.obs;

  Rx<Hilo?> hilo = Rx(null);

  DateTime? ultimoComentario;

  Rx<String?> taggueo = Rx(null);

  Rx<bool> cargandoComentarios = false.obs;
  Rx<List<Comentario>> comentarios = Rx([]);

  final ultimoComentarioAgregadoStream = StreamController<Comentario>();

  Rx<bool> enviando = false.obs;
  Rx<String> comentario = "".obs;
  Rx<Spoileable<Media>?> media = Rx(null);
  List<String> taggueos = [];

  HiloController({required this.id});

  @override
  void onReady() {
    cargar(id);
  }

  Future<void> cargar(String id) async {
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
          ultimoComentarioAgregadoStream.add(c);
        }

        ultimoComentario = r.lastOrNull?.creado_en;

        comentarios.value = [...comentarios.value, ...r];
      },
    );
  }

  Future<void> enviarComentario() async {
    enviando.value = true;

    IComentariosRepository repository = GetIt.I.get();

    var result = await repository.enviar(
      hilo: hilo.value!.id,
      comentario: comentario.value,
    );

    result.fold(
      (l) {
        failure.value = l;
      },
      (r) {},
    );

    enviando.value = false;
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
  }
}
