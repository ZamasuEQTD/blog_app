import 'package:blog_app/features/hilos/domain/ihilos_repository.dart';
import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class PortadasPorTituloController extends GetxController {
  final Rx<String> titulo = "".obs;
  final RxList<PortadaHilo> portadas = <PortadaHilo>[].obs;
  final Rx<HomePortadasStatus> portadasStatus = HomePortadasStatus.initial.obs;

  bool haymas = true;

  Future<void> cargarPortadas() async {
    if (!haymas || portadasStatus.value == HomePortadasStatus.cargando) return;

    portadasStatus.value = HomePortadasStatus.cargando;

    var repository = GetIt.I.get<IHilosRepository>();

    var result = await repository.getPortadas(
      titulo: titulo.value,
      ultimo: portadas.lastOrNull?.id,
    );

    result.fold(
      (l) {
        portadasStatus.value = HomePortadasStatus.fallido;
      },
      (r) {
        portadas.value = [...portadas, ...r];

        if (r.isEmpty) {
          haymas = false;
        }

        portadasStatus.value = HomePortadasStatus.cargado;
      },
    );

    portadasStatus.value = HomePortadasStatus.initial;
  }
}

enum HomePortadasStatus {
  initial,
  cargando,
  cargado,
  fallido,
}
