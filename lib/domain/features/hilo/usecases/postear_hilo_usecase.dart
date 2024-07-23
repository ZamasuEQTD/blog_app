import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

class PostearHiloUsecase extends IUsecase<PostearHiloRequest, String> {
  @override
  Future<Either<Failure, String>> handle(PostearHiloRequest request) {
    // TODO: implement handle
    throw UnimplementedError();
  }
}

class PostearHiloRequest {
  
}