import 'package:blog_app/features/notificaciones/data/dio_notificaciones_repository.dart';
import 'package:get_it/get_it.dart';

import '../../features/notificaciones/domain/inotificaciones_repository.dart';

extension NotificacionesDependencies on GetIt {
  GetIt addNotificaciones() {
    registerLazySingleton<INotificacionesRepository>(
      () => DioNotificacionesRepository(),
    );
    return this;
  }
}
