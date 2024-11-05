import 'package:blog_app/src/lib/features/hilo/data/dio_hilos.repository.dart';
import 'package:blog_app/src/lib/features/moderacion/domain/imoderacion_repository.dart';
import 'package:blog_app/src/lib/features/moderacion/domain/models/registro_de_comentario.dart';
import 'package:blog_app/src/lib/features/moderacion/domain/models/registro_de_hilo.dart';
import 'package:blog_app/src/lib/features/moderacion/domain/models/usuario.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
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

      return Right(
        response.data.map((e) => ComentarioHistorial.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return const Left(Failures.unknown);
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
        return const Left(NetworkFailures.serverError);
      }

      return Right(
        response.data.map((e) => HiloHistorial.fromJson(e)).toList(),
      );
    } on DioException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return const Left(Failures.unknown);
    }
  }

  @override
  Future<Either<Failure, Usuario>> verUsuario({required String usuario}) async {
    try {
      Response response = await dio.get("moderacion/usuario/$usuario");

      if (response.statusCode != 200) {
        return const Left(NetworkFailures.serverError);
      }

      return Right(Usuario.fromJson(response.data));
    } on DioException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return const Left(Failures.unknown);
    }
  }
}
