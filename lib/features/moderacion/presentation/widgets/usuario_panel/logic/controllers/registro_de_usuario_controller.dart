import 'package:blog_app/features/moderacion/domain/imoderacion_repository.dart';
import 'package:blog_app/features/moderacion/domain/models/registro_usuario.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class RegistroDeUsuarioController extends GetxController
    with
        RegistroDeUsuarioControllerMixin,
        RegistroHiloComentadoMixin,
        RegistroHiloPosteadoMixin {
  RegistroDeUsuarioController({
    required String id,
  }) {
    this.id = id;
  }

  final registro = Rx(RegistroSeleccionado.hilo);

  bool get isHilos => registro.value == RegistroSeleccionado.hilo;
  bool get isComentarios => registro.value == RegistroSeleccionado.comentario;

  void cargarRegistros() async {
    if (isHilos) {
      cargarRegistrosHiloPosteado();
    } else {
      cargarRegistrosHiloComentado();
    }
  }
}

enum RegistroSeleccionado { hilo, comentario }

mixin RegistroDeUsuarioControllerMixin on GetxController {
  late final String id;

  final Rx<RegistroUsuario?> usuario = Rx(null);
  final status = Rx(RegistroDeUsuarioStatus.initial);

  bool get isUsuarioCargando =>
      status.value == RegistroDeUsuarioStatus.cargando;

  bool get isUsuarioCargado => status.value == RegistroDeUsuarioStatus.cargado;

  void cargarUsuario() async {
    status.value = RegistroDeUsuarioStatus.cargando;

    final repository = GetIt.I.get<IModeracionRepository>();

    final res = await repository.getUsuarioRegistro(usuario: id);

    res.fold(
      (l) => status.value = RegistroDeUsuarioStatus.failure,
      (r) {
        usuario.value = r;

        status.value = RegistroDeUsuarioStatus.cargado;
      },
    );
  }
}

enum RegistroDeUsuarioStatus { initial, cargando, cargado, failure }

mixin RegistroHiloComentadoMixin on GetxController {
  late final String id;
  final hiloComentadoStatus = Rx(RegistroHiloComentadoStatus.initial);

  final Rx<List<HiloComentadoRegistro>> comentarios = Rx([]);

  bool get isComentariosCargados =>
      hiloComentadoStatus.value == RegistroHiloComentadoStatus.cargado;

  void cargarRegistrosHiloComentado() async {
    if (hiloComentadoStatus.value == RegistroHiloComentadoStatus.cargando) {
      return;
    }
    hiloComentadoStatus.value = RegistroHiloComentadoStatus.cargando;

    final repository = GetIt.I.get<IModeracionRepository>();

    final res = await repository.getComentarioHistorials(usuario: id);

    res.fold(
      (l) => hiloComentadoStatus.value = RegistroHiloComentadoStatus.failure,
      (r) {
        comentarios.value = [...comentarios.value, ...r];

        hiloComentadoStatus.value = RegistroHiloComentadoStatus.cargado;
      },
    );

    hiloComentadoStatus.value = RegistroHiloComentadoStatus.initial;
  }
}

enum RegistroHiloComentadoStatus { initial, cargando, cargado, failure }

mixin RegistroHiloPosteadoMixin on GetxController {
  late final String id;

  final Rx<List<HiloPosteadoRegistro>> hilos = Rx([]);
  final hiloPosteadoStatus = Rx(RegistroHiloPosteadoStatus.initial);

  bool get isHilosCargados =>
      hiloPosteadoStatus.value == RegistroHiloPosteadoStatus.cargado;

  void cargarRegistrosHiloPosteado() async {
    if (hiloPosteadoStatus.value == RegistroHiloPosteadoStatus.cargando) {
      return;
    }
    hiloPosteadoStatus.value = RegistroHiloPosteadoStatus.cargando;

    final repository = GetIt.I.get<IModeracionRepository>();

    final res = await repository.getHistorialHilos(usuario: id);

    res.fold(
      (l) => hiloPosteadoStatus.value = RegistroHiloPosteadoStatus.failure,
      (r) {
        hilos.value = [...hilos.value, ...r];
        hiloPosteadoStatus.value = RegistroHiloPosteadoStatus.cargado;
      },
    );

    hiloPosteadoStatus.value = RegistroHiloPosteadoStatus.initial;
  }
}

enum RegistroHiloPosteadoStatus { initial, cargando, cargado, failure }
