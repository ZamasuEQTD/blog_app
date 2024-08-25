import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:blog_app/features/hilos/domain/models/comentario.dart';
import 'package:dartz/dartz.dart';

class GetComentariosDeHiloUsecase
    extends IUsecase<GetComentariosDeHiloRequest, List<ComentarioListEntry>> {
  @override
  Future<Either<Failure, List<ComentarioListEntry>>> handle(
      GetComentariosDeHiloRequest request) async {
    return const Right([]);
  }
}

class GetComentariosDeHiloRequest {}
