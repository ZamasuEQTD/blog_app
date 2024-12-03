import 'package:blog_app/features/app/clases/failure.dart';
import 'package:dio/dio.dart';

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
    code: "server_error",
    descripcion: "Error del servidor",
  );

  static const Failure sinConexion = Failure(
    code: "sin_conexion",
    descripcion: "Sin conexión a internet",
  );
}
