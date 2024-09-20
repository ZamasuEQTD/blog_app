import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

class OcultarHiloUsecase extends IUsecase<OcultarHiloParams, Unit> {
  @override
  Future<Either<Failure, Unit>> handle(OcultarHiloParams request) {
    // TODO: implement handle
    throw UnimplementedError();
  }
}

class OcultarHiloParams {}
