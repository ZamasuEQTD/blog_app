import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/notificaciones/domain/inotificaciones_repository.dart';
import 'package:blog_app/features/notificaciones/domain/models/notificacion.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class MisNotificacionesController extends GetxController {
  Rx<NotificacionesStatus> status = NotificacionesStatus.initial.obs;

  Rx<List<Notificacion>> notificaciones = Rx([]);

  Rx<Failure?> failure = null.obs;

  bool get cargando => status.value == NotificacionesStatus.cargando;

  void cargar() async {
    if (cargando) return;
    await Future.delayed(const Duration(seconds: 10));
    status.value = NotificacionesStatus.cargando;

    final INotificacionesRepository repository = GetIt.I.get();

    var result = await repository.getMisNotificaciones();

    result.fold(
      (l) {
        failure.value = l;

        status.value = NotificacionesStatus.failure;
      },
      (r) => notificaciones.value = [...notificaciones.value, ...r],
    );

    status.value = NotificacionesStatus.initial;
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

enum NotificacionesStatus { initial, cargando, cargadas, failure }
