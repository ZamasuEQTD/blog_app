import 'package:blog_app/src/lib/features/app/domain/models/spoileable.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/icomentarios_repository.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/comentario.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/src/lib/features/hilo/data/dio_hilos.repository.dart';
import 'package:blog_app/src/lib/features/hilo/domain/models/types.dart';
import 'package:blog_app/src/lib/features/media/data/file_picker_gallery_service.dart';
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
    Spoileable<Media>? media,
  }) async {
    try {
      Response response = await dio.post(
        "/comentarios/comentar-hilo/$hilo",
        data: FormData.fromMap({
          "texto": comentario,
          if (media != null) ...{
            "es_spoiler": true,
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
    DateTime? ultimoComentario,
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
    required ComentarioId id,
  }) async {
    try {
      Response response = await dio.post("comentarios/eliminar/$id");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> ocultar({required ComentarioId id}) async {
    try {
      Response response = await dio.post("comentarios/ocultar/$id");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> denunciar({required ComentarioId id}) {
    // TODO: implement denunciar
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
