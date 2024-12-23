import 'package:blog_app/features/hilos/domain/ihilos_repository.dart';
import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'enum/portadas_status.dart';

class PortadasPorTituloController extends GetxController {
  final Rx<String> titulo = "".obs;
  final RxList<PortadaHilo> portadas = <PortadaHilo>[].obs;
  final Rx<PortadasStatus> portadasStatus = PortadasStatus.initial.obs;

  bool haymas = true;

  Future<void> cargarPortadas() async {
    if (!haymas || portadasStatus.value == PortadasStatus.cargando) return;

    portadasStatus.value = PortadasStatus.cargando;

    var repository = GetIt.I.get<IHilosRepository>();

    var result = await repository.getPortadas(
      titulo: titulo.value,
      ultimo: portadas.lastOrNull?.id,
    );

    result.fold(
      (l) {
        portadasStatus.value = PortadasStatus.fallido;
      },
      (r) {
        portadas.value = [...portadas, ...r];

        if (r.isEmpty) {
          haymas = false;
        }

        portadasStatus.value = PortadasStatus.cargado;
      },
    );

    portadasStatus.value = PortadasStatus.initial;
  }
}
