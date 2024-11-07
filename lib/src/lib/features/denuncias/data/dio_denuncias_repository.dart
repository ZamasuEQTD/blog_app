import 'package:blog_app/src/lib/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/src/lib/features/denuncias/domain/idenuncias_repository.dart';
import 'package:blog_app/src/lib/features/hilo/data/dio_hilos.repository.dart';
import 'package:blog_app/src/lib/features/hilo/domain/models/types.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class DioDenunciasRepository extends IDenunciasRepository {
  final Dio dio = GetIt.I.get();

  @override
  Future<Either<Failure, Unit>> denunciarComentario({
    required ComentarioId id,
  }) async {
    try {
      Response response = await dio.post("denuncias/comentario/$id");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> denunciarHilo({required HiloId id}) async {
    try {
      Response response = await dio.post("denuncias/hilo/$id");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }
}
