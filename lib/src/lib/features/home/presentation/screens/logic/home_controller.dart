import 'package:blog_app/src/lib/features/categorias/domain/models/categoria.dart';
import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:blog_app/src/lib/features/home/presentation/screens/widgets/home_portada.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class HomeController extends GetxController {
  Rx<Subcategoria?> subcategoria = Rx(null);
  Rx<DateTime?> ultimoBump = Rx(null);
  Rx<String> titulo = Rx("");
  Rx<bool> cargando = Rx(false);

  Rx<Failure?> failure = Rx(null);

  Rx<List<HomePortada>> portadas = Rx([]);

  Future cargarPortadas() async {
    if (cargando.value) return;
    IHilosRepository repository = GetIt.I.get();

    cargando.value = true;

    List<HomePortada> portadas = [
      ...this.portadas.value,
    ];

    this.portadas.value = [
      ...this.portadas.value,
      ...List.generate(15, (index) => const HomePortadaBone()),
    ];

    var response = await repository.getPortadas(
      ultimoBump: ultimoBump.value,
      subcategoria: subcategoria.value?.id,
      titulo: titulo.value,
    );

    response.fold(
      (l) => failure.value = l,
      (r) {
        ultimoBump.value = r.lastOrNull?.ultimoBump;

        this.portadas.value = [
          ...portadas,
          ...r.map(
            (e) => HomePortadaLoaded(portada: e),
          ),
        ];
      },
    );
  }

  void filtrar() {
    portadas.value = [];

    cargarPortadas();
  }

  void eliminar(PortadaId id) => portadas.value = portadas.value
      .where(
        (element) => element is HomePortadaLoaded && element.portada.id != id,
      )
      .toList();

  void agregarPortada(HomePortadaLoaded portada) {
    if (hayFiltrosCambiados) return;

    portadas.value = [portada, ...portadas.value];
  }

  void cambiarCategoria(Subcategoria subcategoria) =>
      this.subcategoria.value = subcategoria;

  bool get hayFiltrosCambiados =>
      subcategoria.value != null || titulo.value != "";
}
