import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:blog_app/domain/features/comentarios/entities/comentario.dart';
import 'package:blog_app/domain/features/hilo/entities/hilo.dart';
import 'package:dartz/dartz.dart';

class GetComentariosUseCase extends IUsecase<GetComentariosRequest,List<Comentario>> {
  
  @override
  Future<Either<Failure, List<Comentario>>> handle(GetComentariosRequest request) {
    // TODO: implement handle
    throw UnimplementedError();
  }
  
}



class GetComentariosRequest {
  final HiloId hiloId;
  const GetComentariosRequest({required this.hiloId})  ;
}