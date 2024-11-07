import 'package:blog_app/src/lib/features/app/domain/models/spoileable.dart';
import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:blog_app/src/lib/features/hilo/domain/models/types.dart';
import 'package:blog_app/src/lib/features/media/domain/models/media.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../categorias/domain/models/subcategoria.dart';

class PostearHiloController extends GetxController {
  final IHilosRepository repository = GetIt.I.get();

  Rx<String> titulo = Rx("");
  Rx<String> descripcion = Rx("");

  Rx<int?> respuestaEliminada = Rx(null);
  Rx<List<String>> encuesta = Rx([]);

  Rx<bool> idunico = Rx(false);
  Rx<bool> dados = Rx(false);

  Rx<SubcategoriaId?> subcategoria = Rx(null);

  Rx<HiloId?> id = Rx(null);

  Rx<Spoileable<Media>?> portada = Rx(null);

  RxBool posteando = false.obs;

  Rx<Failure?> failure = Rx(null);
  void postear() async {
    if (portada.value == null) {
      failure.value = PotearHiloFailures.sinPortada;
      return;
    }

    if (subcategoria.value == null) {
      failure.value = PotearHiloFailures.sinSubcategoria;
      return;
    }

    posteando.value = true;

    var result = await repository.postear(
      titulo: titulo.value,
      encuesta: encuesta.value,
      descripcion: descripcion.value,
      portada: portada.value!,
      subcategoria: subcategoria.value!,
      idUnico: idunico.value,
      dados: dados.value,
    );

    id.value = null;

    result.fold(
      (l) => failure.value = l,
      (r) => id.value = r,
    );

    posteando.value = false;
  }

  void agregarPortada(Media portada) {
    this.portada.value = Spoileable(false, portada);
  }

  void censurar() {
    portada.value = portada.value!.copyWith(
      spoiler: !portada.value!.esSpoiler,
    );
  }

  void eliminarRespuesta(int idx) {
    respuestaEliminada.value = idx;

    respuestaEliminada.refresh();

    encuesta.value.removeAt(idx);

    encuesta.refresh();
  }

  void agregarRespuesta() {
    if (encuesta.value.length >= 4) return;

    encuesta.value = [...encuesta.value, ""];
  }
}

class PotearHiloFailures {
  static const Failure sinPortada = Failure(
    code: "sin_portada",
    descripcion: "Debes agregar una portada",
  );

  static const Failure sinSubcategoria = Failure(
    code: "sin_subcategoria",
    descripcion: "Debes seleccionar una subcategoria",
  );
}
