import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/notificaciones/domain/inotificaciones_repository.dart';
import 'package:blog_app/features/notificaciones/domain/models/notificacion.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class MisNotificacionesController extends GetxController {
  var cargando = false.obs;

  Rx<List<Notificacion>> notificaciones = Rx([]);

  Rx<Failure?> failure = null.obs;

  void cargar() async {
    if (cargando.value) return;

    cargando.value = true;

    final INotificacionesRepository repository = GetIt.I.get();

    var result = await repository.getMisNotificaciones();

    result.fold(
      (l) => failure.value = l,
      (r) => notificaciones.value = [...notificaciones.value, ...r],
    );

    cargando.value = false;
  }

  void leerTodas() async {
    final INotificacionesRepository repository = GetIt.I.get();
    var res = await repository.leerTodas();

    res.fold((l) {}, (r) => notificaciones.value.clear());
  }

  void leer(NotificacionId id) async {
    final INotificacionesRepository repository = GetIt.I.get();
    var res = await repository.leerNotificacion(id: id);

    res.fold(
      (l) {},
      (r) => notificaciones.value.removeWhere((e) => e.id == id),
    );
  }
}
