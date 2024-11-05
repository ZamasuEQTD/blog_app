import 'package:blog_app/src/lib/features/moderacion/domain/models/registro_de_hilo.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../domain/imoderacion_repository.dart';
import '../../../domain/models/registro_de_comentario.dart';
import '../../../domain/models/usuario.dart';

class VerUsuarioController extends GetxController {
  Rx<Usuario?> usuario = Rx(null);

  RxBool cargando = false.obs;

  RxBool cargandoHilos = false.obs;
  RxBool cargandoComentarios = false.obs;

  Rx<Historial> historial = Rx(Historial.hilos);
  Rx<List<ComentarioHistorial>> comentarios = Rx([]);
  Rx<List<HiloHistorial>> hilos = Rx([]);

  final String id;

  VerUsuarioController({required this.id});

  Future<void> cargar() async {
    if (cargando.value) return;

    cargando.value = true;

    final IModeracionRepository repository = GetIt.I.get();

    var response = await repository.verUsuario(usuario: id);

    response.fold((l) => null, (r) => usuario.value = r);

    cargando.value = false;
  }

  Future<void> cargarComentarios() async {
    if (cargandoComentarios.value) return;

    cargandoComentarios.value = true;

    final IModeracionRepository repository = GetIt.I.get();

    var response = await repository.getComentarioHistorials(usuario: id);

    response.fold(
      (l) => null,
      (r) => comentarios.value = [...r, ...comentarios.value],
    );

    cargandoComentarios.value = false;
  }

  Future<void> cargarHilos() async {
    if (cargandoHilos.value) return;

    cargandoHilos.value = true;

    final IModeracionRepository repository = GetIt.I.get();

    var response = await repository.getHistorialHilos(usuario: id);

    response.fold((l) => null, (r) => hilos.value = [...r, ...hilos.value]);

    cargandoHilos.value = false;
  }
}

enum Historial { comentarios, hilos }
