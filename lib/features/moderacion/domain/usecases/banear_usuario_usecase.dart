import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

class BanearUsuarioUsecase extends IUsecase<BanearUsuarioParams, Unit> {
  @override
  Future<Either<Failure, Unit>> handle(BanearUsuarioParams request) {
    // TODO: implement handle
    throw UnimplementedError();
  }
}

class BanearUsuarioParams {}
