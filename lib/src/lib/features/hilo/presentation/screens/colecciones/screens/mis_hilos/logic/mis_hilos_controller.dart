import 'package:blog_app/src/lib/features/hilo/domain/icolecciones_repository.dart';
import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_it/get_it.dart';

import '../../../../../logic/classes/coleccion_de_hilo.dart';

abstract class IHiloColeccionController extends GetxController {
  final IColeccionesHilosRepository repository = GetIt.I.get();

  bool finalizado = false;

  Rx<bool> cargando = false.obs;

  Rx<Failure?> failure = Rx<Failure?>(null);

  Rx<List<ColeccionDeHilo>> portadas = Rx<List<ColeccionDeHilo>>([]);

  void cargar();
}

class MisHilosController extends IHiloColeccionController {
  @override
  void cargar() async {
    if (finalizado) return;

    if (cargando.value) return;

    cargando.value = true;

    List<ColeccionDeHilo> portadas = [...this.portadas.value];

    final result = await repository.creados();

    result.fold(
      (l) => failure.value = l,
      (r) => this.portadas.value = [
        ...portadas,
        ...r.map((e) => ColeccionDeHiloLoaded(portada: e)),
      ],
    );

    cargando.value = false;
  }
}
