import 'package:blog_app/src/lib/features/hilo/data/dio_hilos.repository.dart';
import 'package:blog_app/src/lib/features/notificaciones/domain/inotificaciones_repository.dart';
import 'package:blog_app/src/lib/features/notificaciones/domain/models/notificacion.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class DioNotificacionesRepository extends INotificacionesRepository {
  final Dio dio = GetIt.I.get();

  @override
  Future<Either<Failure, List<Notificacion>>> getMisNotificaciones() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> leerNotificacion({
    required NotificacionId id,
  }) async {
    try {
      Response response = await dio.post("notificaciones/leer/$id");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> leerTodas() async {
    try {
      Response response = await dio.post("notificaciones/leer-todas");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }
}
