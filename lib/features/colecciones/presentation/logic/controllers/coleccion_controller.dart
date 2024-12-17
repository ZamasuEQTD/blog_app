import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/hilos/domain/icolecciones_repository.dart';
import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class ColeccionController extends GetxController {
  final Coleccion coleccion;
  final Rx<Failure?> failure = Rx(null);
  final RxList<PortadaHilo> hilos = RxList.empty();
  final Rx<ColeccionStatus> status = Rx(ColeccionStatus.initial);

  ColeccionController({required this.coleccion});

  void cargar() async {
    status.value = ColeccionStatus.loading;

    IColeccionesHilosRepository repository = GetIt.I.get();

    Either<Failure, List<PortadaHilo>> res;

    switch (coleccion) {
      case Coleccion.ocultos:
        res = await repository.ocultos();
        break;
      case Coleccion.seguidos:
        res = await repository.seguidos();
        break;
      case Coleccion.favoritos:
        res = await repository.favoritos();
        break;
    }

    res.fold(
      (l) => {
        failure.value = l,
        status.value = ColeccionStatus.error,
        status.value = ColeccionStatus.initial,
      },
      (r) => {
        hilos.value = [...r, ...hilos],
        status.value = ColeccionStatus.loaded,
      },
    );
  }
}

enum Coleccion {
  ocultos,
  seguidos,
  favoritos,
}

enum ColeccionStatus {
  initial,
  loading,
  loaded,
  error,
}
