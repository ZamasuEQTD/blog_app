import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:blog_app/data/features/hilo/models/get_hilo_request.dart';
import 'package:blog_app/domain/features/comentarios/usecases/get_comentarios.dart';
import 'package:blog_app/domain/features/hilo/entities/hilo.dart';
import 'package:dartz/dartz.dart';

class GetHiloUseCase extends IUsecase<GetHiloRequest, Hilo>{
  @override
  Future<Either<Failure, Hilo>> handle(GetHiloRequest request) {
    throw UnimplementedError();
  }
}

