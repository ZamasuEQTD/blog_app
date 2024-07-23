import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:blog_app/domain/features/comentarios/entities/comentario.dart';
import 'package:dartz/dartz.dart';

class GetComentariosDeHiloUsecase extends IUsecase<GetComentariosDeHiloRequest, List<Comentario>> {
  @override
  Future<Either<Failure, List<Comentario>>> handle(GetComentariosDeHiloRequest request) {
    // TODO: implement handle
    throw UnimplementedError();
  }
  
}


class GetComentariosDeHiloRequest {
  
}