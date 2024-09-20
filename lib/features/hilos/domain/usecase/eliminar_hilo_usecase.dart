import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

class EliminarHiloUsecase extends IUsecase<EliminarHiloParams, Unit> {
  @override
  Future<Either<Failure, Unit>> handle(EliminarHiloParams request) {
    // TODO: implement handle
    throw UnimplementedError();
  }
}

class EliminarHiloParams {}
