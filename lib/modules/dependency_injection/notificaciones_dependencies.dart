import 'package:get_it/get_it.dart';

import '../../features/notificaciones/data/developement/notificaciones_repository.dart';
import '../../features/notificaciones/domain/inotificaciones_repository.dart';

extension NotificacionesDependencies on GetIt {
  GetIt addNotificaciones() {
    registerLazySingleton<INotificacionesRepository>(
      () => LocalNotificacionesRepository(),
    );
    return this;
  }
}
