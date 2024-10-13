import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

import '../models/notificacion.dart';

class GetMisNotificacionesUsecase
    extends IUsecase<GetMisNotificacionesParams, List<Notificacion>> {
  @override
  Future<Either<Failure, List<Notificacion>>> handle(
    GetMisNotificacionesParams request,
  ) {
    // TODO: implement handle
    throw UnimplementedError();
  }
}

class GetMisNotificacionesParams {}
