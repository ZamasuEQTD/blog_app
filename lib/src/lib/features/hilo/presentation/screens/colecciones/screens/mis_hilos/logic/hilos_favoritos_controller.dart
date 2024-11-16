import 'package:blog_app/src/lib/features/hilo/presentation/logic/classes/coleccion_de_hilo.dart';

import 'mis_hilos_controller.dart';

class HilosFavoritosController extends IHiloColeccionController {
  @override
  void cargar() async {
    if (finalizado) return;

    if (cargando.value) return;

    cargando.value = true;

    List<ColeccionDeHilo> portadas = [...this.portadas.value];

    final result = await repository.favoritos();

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
