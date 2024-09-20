import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

class AgregarAFavoritosUsecase extends IUsecase<AgregarAFavoritosParams, Unit> {
  @override
  Future<Either<Failure, Unit>> handle(AgregarAFavoritosParams request) {
    // TODO: implement handle
    throw UnimplementedError();
  }
}

class AgregarAFavoritosParams {}
