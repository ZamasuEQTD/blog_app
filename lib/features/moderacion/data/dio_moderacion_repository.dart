import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/app/presentation/logic/extensions/failure_extension.dart';
import 'package:blog_app/features/moderacion/domain/imoderacion_repository.dart';
import 'package:blog_app/features/moderacion/domain/models/registro_de_comentario.dart';
import 'package:blog_app/features/moderacion/domain/models/registro_de_hilo.dart';
import 'package:blog_app/features/moderacion/domain/models/usuario.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class DioModeracionRepository extends IModeracionRepository {
  final Dio dio = GetIt.I.get();
  DioModeracionRepository();

  @override
  Future<Either<Failure, List<ComentarioHistorial>>> getComentarioHistorials({
    required String usuario,
    DateTime? ultimo,
  }) async {
    try {
      Response response =
          await dio.get("moderacion/historial-de-usuario/comentarios/$usuario");

      if (response.statusCode != 200) {
        return const Left(NetworkFailures.serverError);
      }

      throw Exception();
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, List<HiloHistorial>>> getHistorialHilos({
    required String usuario,
    DateTime? ultimo,
  }) async {
    try {
      Response response =
          await dio.get("moderacion/historial-de-usuario/hilos/$usuario");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      throw Exception();
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Usuario>> verUsuario({required String usuario}) async {
    try {
      Response response = await dio.get("moderacion/usuario/$usuario");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return Right(Usuario.fromJson(response.data));
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }
}
