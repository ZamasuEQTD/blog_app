import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/app/domain/models/spoileable.dart';
import 'package:blog_app/features/app/presentation/logic/extensions/failure_extension.dart';
import 'package:blog_app/features/app/presentation/logic/extensions/response_extension.dart';
import 'package:blog_app/features/categorias/domain/models/categoria.dart';
import 'package:blog_app/features/hilos/domain/models/hilo.dart';
import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:blog_app/features/hilos/presentation/widgets/denunciar_hilo/denunciar_hilo.dart';
import 'package:blog_app/features/media/data/file_picker_gallery_service.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:blog_app/modules/config/api_config.dart';
import 'package:blog_app/features/hilos/domain/ihilos_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../domain/models/types.dart';

class DioHilosRepository extends IHilosRepository {
  final Dio dio = GetIt.I.get();

  DioHilosRepository();

  @override
  Future<Either<Failure, Unit>> eliminar({required String id}) async {
    try {
      Response response = await dio.delete("/hilos/eliminar/$id");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Hilo>> getHilo({required String id}) async {
    try {
      Response response = await dio.get("/hilos/$id");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      Map<String, dynamic> value = response.data["value"];

      return Right(
        Hilo.fromJson({
          ...value,
        }),
      );
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, List<PortadaHilo>>> getPortadas({
    String? titulo,
    SubcategoriaId? subcategoria,
    HiloId? ultimo,
  }) async {
    try {
      Response<Map<String, dynamic>> response = await dio.get(
        "/hilos/portadas",
        queryParameters: {
          "titulo": titulo,
          "subcategoria": subcategoria,
          "ultimo": ultimo,
        },
      );

      if (response.isFailure) {
        return Left(response.failure);
      }

      List<Map<String, dynamic>> value = List.from(response.data!["value"]);

      var portadas = value
          .map(
            (p) => PortadaHilo.fromJson({
              ...p,
            }),
          )
          .toList();

      return Right(portadas);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> ocultar({required String id}) async {
    try {
      Response response =
          await dio.post("/hilos/colecciones/ocultos/ocultar/$id");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> ponerEnFavoritos({required String id}) async {
    try {
      Response response = await dio
          .post("/hilos/colecciones/favoritos/poner-en-favoritos/$id}");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, HiloId>> postear({
    required String titulo,
    required String descripcion,
    required Spoileable<Media> portada,
    required SubcategoriaId subcategoria,
    required List<String> encuesta,
    required bool dados,
    required bool idUnico,
  }) async {
    try {
      FormData data = FormData.fromMap({
        "titulo": titulo,
        "descripcion": descripcion,
        "encuesta": encuesta,
        "subcategoria": subcategoria,
        "dadosActivados": dados,
        "idUnicoActivado": idUnico,
        "spoiler": portada.esSpoiler,
        if (portada.spoileable is Youtube)
          "embed":
              ((portada.spoileable as Youtube).provider as NetworkProvider).path
        else
          "file": await MultipartFile.fromFile(
            portada.spoileable.provider.path,
            contentType: DioMediaType(
              MimeService.getMime(portada.spoileable.provider.path)
                  .split("/")
                  .first,
              MimeService.getMime(portada.spoileable.provider.path)
                  .split("/")
                  .last,
            ),
          ),
      });

      Response response = await dio.post("/hilos/postear", data: data);

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return Right(response.data["value"]);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> seguir({required String id}) async {
    try {
      Response response =
          await dio.post("/hilos/colecciones/seguidos/seguir/$id");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> establecerSticky({required String id}) async {
    try {
      Response response = await dio.post("/hilos/establecer-sticky/$id");

      if (response.isFailure) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> denunciar({
    required String id,
    required HiloRazonDenuncia denuncia,
  }) async {
    try {
      Response response = await dio.post(
        "/hilos/$id/denunciar",
        data: {
          "denuncia": denuncia,
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
  Future<Either<Failure, Unit>> eliminarSticky({required String id}) async {
    try {
      Response response = await dio.delete("/hilos/eliminar-sticky/$id");

      if (response.isFailure) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> cambiarNotificaciones({
    required String id,
  }) async {
    try {
      Response response =
          await dio.post("/hilos/$id/desactivar-notificaciones");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> cambiarSubcategoria({
    required String id,
    required SubcategoriaId nuevaSubcategoria,
  }) {
    // TODO: implement cambiarSubcategoria
    throw UnimplementedError();
  }
}

class HilosFailures {
  static const Failure hiloNoEncontrado = Failure(
    code: "hilo_no_encontrado",
    descripcion: "Hilo no encontrado",
  );
}
