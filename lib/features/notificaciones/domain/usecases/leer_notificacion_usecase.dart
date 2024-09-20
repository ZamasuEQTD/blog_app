import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

class LeerNotificacionUsecase extends IUsecase<LeerNotificacionParams, Unit> {
  @override
  Future<Either<Failure, Unit>> handle(LeerNotificacionParams request) {
    // TODO: implement handle
    throw UnimplementedError();
  }
}

class LeerNotificacionParams {}
