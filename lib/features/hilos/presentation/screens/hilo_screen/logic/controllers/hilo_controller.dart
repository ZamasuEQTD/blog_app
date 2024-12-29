import 'dart:collection';

import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/app/domain/models/spoileable.dart';
import 'package:blog_app/features/hilos/domain/ihilos_repository.dart';
import 'package:blog_app/features/hilos/domain/models/hilo.dart';
import 'package:blog_app/features/hilos/domain/models/types.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../comentarios/domain/icomentarios_repository.dart';
import '../../../../../../comentarios/domain/models/comentario.dart';
import '../../../../../../comentarios/domain/models/typedef.dart';

class HiloController extends GetxController
    with HiloMixin, ComentariosHiloMixin, ComentarHiloMixin {
  HiloController({
    required String id,
  }) {
    this.id = id;
  }

  @override
  void onInit() {
    failure.listen((value) {
      if (value != null) {
        failure.value = null;
      }
    });
    super.onInit();
  }
}

mixin HiloMixin {
  late final HiloId id;

  Rx<Hilo?> hilo = Rx(null);

  Rx<HiloStatus> hiloStatus = Rx(HiloStatus.initial);

  Future<void> cargarHilo() async {
    if (hiloStatus.value == HiloStatus.cargando) {
      return;
    }

    Rx<Failure?> failure = Rx(null);

    hiloStatus.value = HiloStatus.cargando;

    final IHilosRepository repository = GetIt.I.get<IHilosRepository>();

    var res = await repository.getHilo(id: id);

    res.fold((l) {
      failure.value = l;

      hiloStatus.value = HiloStatus.initial;
    }, (r) {
      hilo.value = r;

      hiloStatus.value = HiloStatus.cargado;
    });
  }
}

enum HiloStatus {
  initial,
  cargando,
  cargado,
  error,
}

mixin ComentariosHiloMixin on GetxController {
  late final HiloId id;

  Rx<Failure?> failure = Rx(null);

  Rx<List<Comentario>> comentarios = Rx([]);

  var comentariosStatus = Rx(HiloComentariosStatus.initial);

  Rx<HashMap<String, List<String>>> taggueos = Rx(HashMap());

  Rx<Comentario?> ultimoComentarioAgregado = Rx(null);

  HashMap<String, Comentario> comentariosByTag = HashMap();

  Rx<ComentarioId?> ultimoComentarioEliminado = Rx(null);

  @override
  void onInit() {
    ultimoComentarioAgregado.stream.listen(
      (c) {
        if (c == null) return;

        comentariosByTag[c.detalles.tag] = c;
      },
    );
    super.onInit();
  }

  Future<void> cargarComentarios() async {
    if (comentariosStatus.value == HiloComentariosStatus.cargando) {
      return;
    }

    comentariosStatus.value = HiloComentariosStatus.cargando;

    final IComentariosRepository repository =
        GetIt.I.get<IComentariosRepository>();

    var res = await repository.getComentarios(
      hilo: id,
      ultimoComentario: comentarios.value.lastOrNull?.id,
    );

    res.fold((l) {
      failure.value = l;
    }, (r) {
      comentarios.value = [...comentarios.value, ...r];

      for (var comentario in r) {
        ultimoComentarioAgregado.value = comentario;
      }

      comentariosStatus.value = HiloComentariosStatus.cargados;
    });

    comentariosStatus.value = HiloComentariosStatus.initial;
  }

  void agregarComentario(Comentario comentario) {
    comentarios.value = [
      ...comentarios.value,
      comentario,
    ];

    ultimoComentarioAgregado.value = comentario;
  }

  void eliminarComentario(ComentarioId id) {
    comentarios.value =
        comentarios.value.where((element) => element.id != id).toList();
  }
}

enum HiloComentariosStatus {
  initial,
  cargando,
  cargados,
  sinMasComentarios,
  error,
}

mixin ComentarHiloMixin {
  late final HiloId id;

  Rx<Failure?> failure = Rx(null);

  Rx<ComentarHiloStatus> comentarHiloStatus = Rx(ComentarHiloStatus.initial);

  List<String> tags = [];

  Rx<String?> ultimoTagueo = Rx(null);

  Rx<ContenidoCensurable<Media>?> media = Rx(null);

  Future<void> enviarComentario(String comentario) async {
    if (comentarHiloStatus.value == ComentarHiloStatus.enviando) {
      return;
    }

    comentarHiloStatus.value = ComentarHiloStatus.enviando;

    final IComentariosRepository repository =
        GetIt.I.get<IComentariosRepository>();

    var res = await repository.enviar(
      hilo: id,
      comentario: comentario,
      media: media.value,
    );

    res.fold((l) {
      failure.value = l;

      comentarHiloStatus.value = ComentarHiloStatus.fallido;
    }, (r) {
      comentarHiloStatus.value = ComentarHiloStatus.enviado;
    });

    comentarHiloStatus.value = ComentarHiloStatus.initial;
  }

  void tagguear(String tag) {
    if (tags.contains(tag)) {
      return;
    }
    if (tags.length > 5) {
      failure.value = const Failure(
        code: "tag_limit",
        descripcion: "No puedes tagguear más de 5 tags",
      );
      return;
    }

    ultimoTagueo.value = tag;

    tags.add(tag);
  }
}

enum ComentarHiloStatus { initial, enviando, enviado, fallido }
