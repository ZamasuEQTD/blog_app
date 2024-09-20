import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

class PonerHiloEnFavoritoUsecase
    extends IUsecase<PonerhiloEnFavoritoParams, Unit> {
  @override
  Future<Either<Failure, Unit>> handle(PonerhiloEnFavoritoParams request) {
    throw UnimplementedError();
  }
}

class PonerhiloEnFavoritoParams {}
