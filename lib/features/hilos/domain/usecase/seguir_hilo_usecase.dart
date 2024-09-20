import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

class SeguirHiloUsecase extends IUsecase<SeguirHiloParams, Unit> {
  @override
  Future<Either<Failure, Unit>> handle(SeguirHiloParams request) {
    // TODO: implement handle
    throw UnimplementedError();
  }
}

class SeguirHiloParams {}
