import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/app/domain/models/spoileable.dart';
import 'package:blog_app/features/app/presentation/logic/extensions/failure_extension.dart';
import 'package:blog_app/features/comentarios/domain/icomentarios_repository.dart';
import 'package:blog_app/features/hilos/domain/models/types.dart';
import 'package:blog_app/features/media/data/file_picker_gallery_service.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../domain/models/comentario.dart';
import '../domain/models/typedef.dart';

class DioComentariosRepository extends IComentariosRepository {
  final Dio dio = GetIt.I.get();

  @override
  Future<Either<Failure, Unit>> enviar({
    required HiloId hilo,
    required String comentario,
    Spoileable<Media>? media,
  }) async {
    try {
      Response response = await dio.post(
        "/comentarios/comentar-hilo/$hilo",
        data: FormData.fromMap({
          "texto": comentario,
          if (media != null) ...{
            "es_spoiler": media.spoiler,
            "media": await MultipartFile.fromFile(
              media.spoileable.provider.path,
              contentType: DioMediaType(
                MimeService.getMime(media.spoileable.provider.path)
                    .split("/")
                    .first,
                MimeService.getMime(media.spoileable.provider.path)
                    .split("/")
                    .last,
              ),
            ),
          },
        }),
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
    String? ultimoComentario,
  }) async {
    try {
      Response response = await dio.get(
        "/comentarios/hilo/$hilo",
        queryParameters: {
          "ultimo_comentario": ultimoComentario,
        },
      );

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      List<Map<String, dynamic>> value = List.from(response.data!["value"]);

      var comentarios = value
          .map(
            (e) => Comentario.fromJson({
              ...e,
            }),
          )
          .toList();

      return Right(comentarios);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> eliminar({
    required HiloId hilo,
    required ComentarioId comentario,
  }) async {
    try {
      Response response = await dio
          .delete("comentarios/eliminar/hilo/$hilo/comentario/$comentario");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> ocultar({
    required HiloId hilo,
    required ComentarioId comentario,
  }) async {
    try {
      Response response = await dio.post("hilo/$hilo/destacar/$comentario");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> denunciar({
    required HiloId hilo,
    required ComentarioId comentario,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> destacar({
    required HiloId hilo,
    required ComentarioId comentario,
  }) async {
    try {
      Response response =
          await dio.post("/comentarios/hilo/$hilo/destacar/$comentario");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }
}
