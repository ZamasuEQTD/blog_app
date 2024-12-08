import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/app/domain/models/spoileable.dart';
import 'package:blog_app/features/app/presentation/logic/extensions/failure_extension.dart';
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
      Response response = await dio.delete("hilos/$id");

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
          "media": {
            ...value["media"],
            if (value["media"]["previsualizacion"] != null)
              "previsualizacion":
                  ApiConfig.media + value["media"]["previsualizacion"],
            "url": ApiConfig.media + value["media"]["url"],
          },
          "subcategoria": {
            ...value["subcategoria"],
            "imagen": ApiConfig.media + value["subcategoria"]["imagen"],
          },
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
    DateTime? ultimoBump,
  }) async {
    try {
      Response<Map<String, dynamic>> response = await dio.get(
        "/hilos/portadas",
        queryParameters: {
          "titulo": titulo,
          "subcategoria": subcategoria,
          "ultimo_bump": ultimoBump,
        },
      );

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      List<Map<String, dynamic>> value = List.from(response.data!["value"]);

      var portadas = value
          .map(
            (p) => PortadaHilo.fromJson({
              ...p,
              "miniatura": {
                ...p["miniatura"],
                "url": ApiConfig.media + p["miniatura"]["url"],
              },
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
      Response response = await dio.post("hilos/$id/ocultar");

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
      Response response = await dio.post("hilos/$id/poner-en-favoritos");

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
        "dados": dados,
        "id_unico": idUnico,
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
      Response response = await dio.post("hilos/$id/seguir");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> desactivarNotificaciones({
    required String id,
  }) async {
    try {
      Response response = await dio.post("hilos/$id/desactivar-notificaciones");

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
      Response response = await dio.post("hilos/$id/establecer-sticky");

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
    required String id,
    required HiloRazonDenuncia denuncia,
  }) async {
    try {
      Response response = await dio.post(
        "hilos/$id/denunciar",
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
}

class HilosFailures {
  static const Failure hiloNoEncontrado = Failure(
    code: "hilo_no_encontrado",
    descripcion: "Hilo no encontrado",
  );
}
