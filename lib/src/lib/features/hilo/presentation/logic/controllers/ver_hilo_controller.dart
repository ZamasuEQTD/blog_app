import 'dart:collection';

import 'package:blog_app/src/lib/features/comentarios/domain/icomentarios_repository.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/comentario.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:blog_app/src/lib/features/hilo/domain/services/tag_service.dart';
import 'package:blog_app/src/lib/features/media/domain/models/media.dart';
import 'package:blog_app/src/lib/features/moderacion/domain/models/usuario.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/models/hilo.dart';

class VerHiloController extends GetxController {
  ScrollController scrollController = ScrollController();

  Rx<Failure?> failure = Rx(null);
  Rx<bool> cargando = false.obs;

  Rx<Hilo?> hilo = Rx(null);

  DateTime? ultimoComentario;

  Rx<bool> cargandoComentarios = false.obs;
  Rx<List<Comentario>> comentarios = Rx([]);
  Rx<List<Comentario>> comentariosAgregados = Rx([]);

  TextEditingController comentarioController = TextEditingController();
  Rx<bool> enviando = false.obs;
  Rx<String> comentario = "".obs;
  Rx<Media?> media = Rx(null);
  List<String> taggueos = [];

  @override
  void onInit() {
    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          cargarComentarios();
        }
      },
    );

    comentarioController.addListener(
      () {
        taggueos = TagService.getTags(comentarioController.text);
      },
    );
    super.onInit();
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
        comentariosAgregados.value = r;

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

    taggueos.add(tag);

    comentarioController.text = "${comentarioController.text}>>$tag";
  }

  void agregarMedia(Media media) {
    this.media.value = media;
  }

  void eliminarMedia() {
    media.value = null;
  }
}
