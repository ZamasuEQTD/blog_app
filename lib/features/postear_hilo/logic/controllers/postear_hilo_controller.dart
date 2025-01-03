import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/app/domain/models/spoileable.dart';
import 'package:blog_app/features/categorias/domain/models/categoria.dart';
import 'package:blog_app/features/hilos/domain/models/types.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:blog_app/features/hilos/domain/ihilos_repository.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class PostearHiloController extends GetxController {
  final IHilosRepository repository = GetIt.I.get();

  Rx<String> titulo = Rx("");
  Rx<String> descripcion = Rx("");

  Rx<int?> respuestaEliminada = Rx(null);
  Rx<List<String>> encuesta = Rx([]);

  Rx<bool> idunico = Rx(false);
  Rx<bool> dados = Rx(false);

  Rx<Subcategoria?> subcategoria = Rx(null);

  Rx<HiloId?> id = Rx(null);

  Rx<ContenidoCensurable<Media>?> portada = Rx(null);

  Rx<PostearHiloStatus> status = PostearHiloStatus.initial.obs;

  Rx<Failure?> failure = Rx(null);

  bool get posteando => status.value == PostearHiloStatus.posteando;

  void postear() async {
    if (status.value == PostearHiloStatus.posteando) return;

    status.value = PostearHiloStatus.posteando;

    if (portada.value == null) {
      failure.value = PotearHiloFailures.sinPortada;
      return;
    }

    if (subcategoria.value == null) {
      failure.value = PotearHiloFailures.sinSubcategoria;
      return;
    }

    var result = await repository.postear(
      titulo: titulo.value,
      encuesta: encuesta.value,
      descripcion: descripcion.value,
      portada: portada.value!,
      subcategoria: subcategoria.value!.id,
      idUnico: idunico.value,
      dados: dados.value,
    );

    id.value = null;

    result.fold(
      (l) {
        failure.value = l;

        status.value = PostearHiloStatus.failure;
      },
      (r) {
        id.value = r;

        status.value = PostearHiloStatus.posteado;
      },
    );

    status.value = PostearHiloStatus.posteado;
  }

  void agregarPortada(Media portada) {
    this.portada.value = ContenidoCensurable(false, portada);
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

enum PostearHiloStatus { initial, posteando, posteado, failure }
