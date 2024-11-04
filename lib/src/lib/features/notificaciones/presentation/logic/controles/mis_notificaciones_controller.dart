import 'package:blog_app/src/lib/features/app/presentation/extensions/scroll_controller_extensions.dart';
import 'package:blog_app/src/lib/features/notificaciones/domain/inotificaciones_repository.dart';
import 'package:blog_app/src/lib/features/notificaciones/domain/models/notificacion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class MisNotificacionesController extends GetxController {
  final INotificacionesRepository repository = GetIt.I.get();

  var cargando = false.obs;

  Rx<List<Notificacion>> notificaciones = Rx([]);

  void cargar() async {
    cargando.value = true;

    var result = await repository.getMisNotificaciones();

    result.fold(
      (l) {},
      (r) => notificaciones.value = [...notificaciones.value, ...r],
    );

    cargando.value = false;
  }

  void leerTodas() async {
    await repository.leerTodas();
  }

  void leer(NotificacionId id) async {
    await repository.leerNotificacion(id: id);
  }
}
