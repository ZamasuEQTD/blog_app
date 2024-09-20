import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

class DenunciarHiloUsecase extends IUsecase<DenunciarHiloParms, Unit> {
  @override
  Future<Either<Failure, Unit>> handle(DenunciarHiloParms request) {
    throw UnimplementedError();
  }
}

class DenunciarHiloParms {}
