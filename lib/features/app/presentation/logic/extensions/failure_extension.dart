import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/baneos/domain/failures/estas_baneado_failure.dart';
import 'package:blog_app/features/baneos/domain/models/baneo.dart';
import 'package:dio/dio.dart';

extension ExceptionFailure on Exception {
  Failure get failure {
    switch (this) {
      case DioException e:
        return e.failure;
    }

    return Failures.unknown;
  }
}

extension DioExceptionExtensions on DioException {
  Failure get failure {
    final data = response!.data!;

    if (data["title"] != null) {
      if (data["title"] == EstasBaneadoFailure.title) {
        return EstasBaneadoFailure(
          descripcion: data["detail"],
          baneo: Baneo.fromJson(data["baneo"]),
        );
      }

      return Failure(code: data["title"], descripcion: data["detail"]);
    }

    return Failures.unknown;
  }
}

extension ResponseFailure on Response {
  Failure get failure {
    if (statusCode != 200) {
      return NetworkFailures.serverError;
    }

    if (data["title"] != null) {
      if (data["title"] == EstasBaneadoFailure.title) {
        return EstasBaneadoFailure(
          baneo: Baneo.fromJson(data["baneo"]),
        );
      }

      return Failure(code: data["title"], descripcion: data["detail"]);
    }

    return Failures.unknown;
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
    code: "Conexion.ErrorServidor",
    descripcion: "Error del servidor",
  );

  static const Failure sinConexion = Failure(
    code: "Conexion.SinConexion",
    descripcion: "Sin conexión a internet",
  );
}
