import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

class DestacarHiloUsecase extends IUsecase<DestacarHiloParams, Unit> {
  @override
  Future<Either<Failure, Unit>> handle(DestacarHiloParams request) {
    // TODO: implement handle
    throw UnimplementedError();
  }
}

class DestacarHiloParams {}
