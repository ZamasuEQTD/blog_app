import 'package:blog_app/features/hilos/domain/models/hilo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/classes/failure.dart';
import '../../../../core/usecases/iusecase.dart';

class PostearHiloUsecase extends IUsecase<PostearHiloRequest, HiloId> {
  @override
  Future<Either<Failure, HiloId>> handle(PostearHiloRequest request) {
    // TODO: implement handle
    throw UnimplementedError();
  }
}

class PostearHiloRequest {}
