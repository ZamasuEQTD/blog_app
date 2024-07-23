import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

class ComentarHiloUsecase extends IUsecase<ComentarHiloRequest, Unit> {

  @override
  Future<Either<Failure, Unit>> handle(ComentarHiloRequest request) {
    throw UnimplementedError();
  }
  
}

class ComentarHiloRequest {}