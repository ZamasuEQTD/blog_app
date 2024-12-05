import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/app/presentation/logic/extensions/failure_extension.dart';
import 'package:blog_app/features/moderacion/domain/imoderacion_repository.dart';
import 'package:blog_app/features/moderacion/domain/models/registro_usuario.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class DioModeracionRepository extends IModeracionRepository {
  final Dio dio = GetIt.I.get();
  DioModeracionRepository();

  @override
  Future<Either<Failure, List<HiloComentadoRegistro>>> getComentarioHistorials({
    required String usuario,
    DateTime? ultimo,
  }) async {
    try {
      Response response = await dio
          .get("moderacion/historial-de-usuario/comentarios/usuario/$usuario");

      if (response.statusCode != 200) {
        return const Left(NetworkFailures.serverError);
      }

      return Right(
        response.data.map((e) => HiloComentadoRegistro.fromJson(e)).toList(),
      );
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, List<HiloPosteadoRegistro>>> getHistorialHilos({
    required String usuario,
    DateTime? ultimo,
  }) async {
    try {
      Response response = await dio
          .get("/moderacion/historial-de-usuario/hilos/usuario/$usuario");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return Right(
        response.data.map((e) => HiloPosteadoRegistro.fromJson(e)).toList(),
      );
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, RegistroUsuario>> getUsuarioRegistro({
    required String usuario,
  }) async {
    try {
      Response response =
          await dio.get("/moderacion/registro/usuario/$usuario");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return Right(RegistroUsuario.fromJson(response.data["value"]));
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }
}
