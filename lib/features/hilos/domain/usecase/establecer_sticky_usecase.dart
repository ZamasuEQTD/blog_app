import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

class EstablecerStickyUsecase extends IUsecase<EstablecerStickyParms, Unit> {
  @override
  Future<Either<Failure, Unit>> handle(EstablecerStickyParms request) {
    // TODO: implement handle
    throw UnimplementedError();
  }
}

class EstablecerStickyParms {}
