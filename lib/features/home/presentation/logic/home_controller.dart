import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/categorias/domain/models/categoria.dart';
import 'package:blog_app/features/hilos/domain/ihilos_repository.dart';
import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:blog_app/features/hilos/domain/models/types.dart';

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class HomeController extends GetxController with HomePortadasMixin {}

mixin HomePortadasMixin {
  Rx<Failure?> failure = Rx(null);
  Rx<Subcategoria?> subcategoria = Rx(null);
  Rx<DateTime?> ultimoBump = Rx(null);
  Rx<String> titulo = Rx("");

  Rx<List<PortadaHilo>> portadas = Rx([]);

  Rx<HiloId?> ultimaPortadaEliminada = Rx(null);

  Rx<HiloId?> ultimaPortadaAgregada = Rx(null);

  Rx<HomePortadasStatus> portadasStatus = Rx(HomePortadasStatus.initial);

  Future<void> cargarPortadas() async {
    if (portadasStatus.value == HomePortadasStatus.cargando) return;

    portadasStatus.value = HomePortadasStatus.cargando;
    IHilosRepository repository = GetIt.I.get();

    var res = await repository.getPortadas(
      titulo: titulo.value,
      subcategoria: subcategoria.value?.id,
      ultimoBump: ultimoBump.value,
    );

    res.fold(
      (l) => failure.value = l,
      (r) {
        ultimoBump.value = r.lastOrNull?.ultimoBump;

        portadas.value = [
          ...portadas.value,
          ...r,
        ];
      },
    );

    portadasStatus.value = HomePortadasStatus.cargados;
  }

  void eliminarPortada(HiloId id) {
    portadas.value = [
      ...portadas.value.where((p) => id != p.id),
    ];

    ultimaPortadaEliminada.value = id;
  }

  void agregarPortada(PortadaHilo portada) {
    portadas.value.insert(portadas.value.stickies, portada);

    portadas.refresh();

    ultimaPortadaAgregada.value = portada.id;
  }
}

extension PortadasExtensions on List<PortadaHilo> {
  int get stickies {
    int count = 0;
    for (var element in this) {
      if (element.esSticky) {
        count++;
      }
      break;
    }
    return count;
  }
}

enum HomePortadasStatus { initial, cargando, cargados, failure }
