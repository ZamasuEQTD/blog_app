import 'package:blog_app/src/lib/features/comentarios/domain/icomentarios_repository.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/comentario.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/src/lib/features/hilo/data/dio_hilos.repository.dart';
import 'package:blog_app/src/lib/features/hilo/domain/models/types.dart';
import 'package:blog_app/src/lib/features/media/domain/models/media.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class DioComentariosRepository extends IComentariosRepository {
  final Dio dio = GetIt.I.get();

  @override
  Future<Either<Failure, Unit>> enviar({
    required HiloId hilo,
    required String comentario,
    Media? media,
  }) async {
    try {
      Response response = await dio.post(
        "comentarios/enviar",
        data: {
          "hilo": hilo,
          "comentario": comentario,
          "media": media,
        },
      );

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, List<Comentario>>> getComentarios({
    required HiloId hilo,
    DateTime? ultimoComentario,
  }) async {
    try {
      Response response =
          await dio.get("comentarios/get/$hilo/$ultimoComentario");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return Right(response.data);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> eliminar({
    required ComentarioId comentario,
  }) async {
    try {
      Response response = await dio.post("comentarios/eliminar/$comentario");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }
}
