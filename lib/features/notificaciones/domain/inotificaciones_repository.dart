import 'package:blog_app/features/app/clases/failure.dart';
import 'package:dartz/dartz.dart';

import 'models/notificacion.dart';

abstract class INotificacionesRepository {
  Future<Either<Failure, NotificacionesContext>> getMisNotificaciones();

  Future<Either<Failure, Unit>> leerNotificacion({
    required NotificacionId id,
  });

  Future<Either<Failure, Unit>> leerTodas();
}
