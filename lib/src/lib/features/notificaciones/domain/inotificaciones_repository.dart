import 'package:dartz/dartz.dart';

import '../../../utils/clases/failure.dart';
import 'models/notificacion.dart';

abstract class INotificacionesRepository {
  Future<Either<Failure, List<Notificacion>>> getMisNotificaciones();
  Future<Either<Failure, Unit>> leerNotificacion({
    required NotificacionId id,
  });

  Future<Either<Failure, Unit>> leerTodas();
}
