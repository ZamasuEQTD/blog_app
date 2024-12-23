import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/colecciones/presentation/logic/controllers/enum/portadas_status.dart';
import 'package:blog_app/features/hilos/domain/icolecciones_repository.dart';
import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class ColeccionController extends GetxController {
  final Coleccion coleccion;
  final Rx<Failure?> failure = Rx(null);
  final RxList<PortadaHilo> hilos = RxList.empty();
  final Rx<PortadasStatus> status = Rx(PortadasStatus.initial);

  ColeccionController({required this.coleccion});

  void cargar() async {
    status.value = PortadasStatus.cargando;

    IColeccionesHilosRepository repository = GetIt.I.get();

    Either<Failure, List<PortadaHilo>> res;

    res = await repository.getColeccion(
      coleccion: coleccion,
    );

    res.fold(
      (l) => {
        failure.value = l,
        status.value = PortadasStatus.fallido,
      },
      (r) => {
        hilos.value = [...r, ...hilos],
        status.value = PortadasStatus.cargado,
      },
    );

    status.value = PortadasStatus.initial;
  }
}

enum Coleccion {
  ocultos,
  seguidos,
  favoritos,
}
