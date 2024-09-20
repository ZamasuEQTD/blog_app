import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

class GetMisNotificacionesUsecase
    extends IUsecase<GetMisNotificacionesParams, Notificacion> {
  @override
  Future<Either<Failure, Notificacion>> handle(
      GetMisNotificacionesParams request) {
    // TODO: implement handle
    throw UnimplementedError();
  }
}

class GetMisNotificacionesParams {}

class Notificacion {}
