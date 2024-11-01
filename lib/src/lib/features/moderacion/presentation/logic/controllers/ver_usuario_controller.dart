import 'package:blog_app/src/lib/features/moderacion/domain/models/registro_de_hilo.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/imoderacion_service.dart';
import '../../../domain/models/registro_de_comentario.dart';
import '../../../domain/models/usuario.dart';

class VerUsuarioController extends GetxController {
  Rx<Usuario?> usuario = Rx(null);

  RxBool cargando = false.obs;

  RxBool cargandoHistorial = false.obs;
  Rx<TipoDeHistorial> historial = Rx(TipoDeHistorial.hilos);
  Rx<List<HistorialComentario>> comentarios = Rx([]);
  Rx<List<HiloHistorial>> hilos = Rx([]);

  final String id;

  VerUsuarioController({required this.id});

  void cargar() async {
    cargando.value = true;

    final IModeracionRepository repository = GetIt.I.get();

    var response = await repository.verUsuario(usuario: id);

    response.fold((l) => null, (r) => usuario.value = r);

    cargando.value = false;
  }

  void cargarHistorial() async {
    if (cargandoHistorial.value) return;

    cargandoHistorial.value = true;

    if (historial.value == TipoDeHistorial.comentarios) {
      await cargarComentarios();
    } else {
      await cargarHilos();
    }

    cargandoHistorial.value = false;
  }

  Future<void> cargarComentarios() async {}
  Future<void> cargarHilos() async {}
}

enum TipoDeHistorial { comentarios, hilos }
