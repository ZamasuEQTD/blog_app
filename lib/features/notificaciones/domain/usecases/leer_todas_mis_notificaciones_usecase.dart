import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

class LeerTodasMisNotificacionesUsecase extends IUsecase<LeerTodasMisNotificacionesParams, Unit> {
  @override
  Future<Either<Failure, Unit>> handle(LeerTodasMisNotificacionesParams request) {
    // TODO: implement handle
    throw UnimplementedError();
  }
}

class LeerTodasMisNotificacionesParams {}
