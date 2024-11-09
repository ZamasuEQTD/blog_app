import 'package:blog_app/src/lib/features/app/domain/models/spoileable.dart';
import 'package:blog_app/src/lib/features/baneos/domain/failures/estas_baneado_failure.dart';
import 'package:blog_app/src/lib/features/categorias/domain/models/subcategoria.dart';
import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:blog_app/src/lib/features/hilo/domain/models/hilo.dart';
import 'package:blog_app/src/lib/features/hilo/domain/models/types.dart';
import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:blog_app/src/lib/features/media/domain/models/media.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../baneos/domain/models/baneo.dart';

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
      Response response = await dio.get("hilos/$id");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return Right(Hilo.fromJson(response.data));
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, List<HomePortada>>> getPortadas({
    String? titulo,
    SubcategoriaId? subcategoria,
    DateTime? ultimoBump,
  }) async {
    try {
      Response response = await dio.get(
        "hilos/portadas",
        queryParameters: {
          "titulo": titulo,
          "subcategoria": subcategoria,
          "ultimo_bump": ultimoBump?.toIso8601String(),
        },
      );

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return Right(response.data.map((e) => HomePortada.fromJson(e)).toList());
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
      Response response = await dio.post("hilos/$id/favoritos");

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
        "categoria": subcategoria,
        "dados": dados,
        "id_unico": idUnico,
        "portada": await MultipartFile.fromFile(
          portada.spoileable.provider.path,
        ),
      });

      Response response = await dio.post("hilos", data: data);

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return Right(response.data["id"]);
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
  Future<Either<Failure, Unit>> desactivarNotificaciones({required String id}) {
    // TODO: implement desactivarNotificaciones
    throw UnimplementedError();
  }
}

extension ExceptionFailure on Exception {
  Failure get failure {
    if (this is DioException) {
      return (this as DioException).failure;
    }

    return Failures.unknown;
  }
}

extension ResponseFailure on Response {
  Failure get failure {
    if (statusCode != 200) {
      return NetworkFailures.serverError;
    }

    return EstasBaneadoFailure(baneo: Baneo.fromJson(data));

    return Failures.unknown;
  }
}

extension DioHilosRepositoryFailure on DioException {
  Failure get failure {
    switch (type) {
      case DioExceptionType.connectionTimeout:
        return NetworkFailures.sinConexion;
      default:
        return NetworkFailures.serverError;
    }
  }
}

class Failures {
  static const Failure unknown = Failure(
    code: "unknown",
    descripcion: "Ha ocurrido un error",
  );
}

class NetworkFailures {
  static const Failure serverError = Failure(
    code: "server_error",
    descripcion: "Error del servidor",
  );

  static const Failure sinConexion = Failure(
    code: "sin_conexion",
    descripcion: "Sin conexión a internet",
  );
}

class HilosFailures {
  static const Failure hiloNoEncontrado = Failure(
    code: "hilo_no_encontrado",
    descripcion: "Hilo no encontrado",
  );
}
