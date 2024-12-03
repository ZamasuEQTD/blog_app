import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/app/presentation/logic/extensions/failure_extension.dart';
import 'package:blog_app/features/notificaciones/domain/inotificaciones_repository.dart';
import 'package:blog_app/features/notificaciones/domain/models/notificacion.dart';
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
