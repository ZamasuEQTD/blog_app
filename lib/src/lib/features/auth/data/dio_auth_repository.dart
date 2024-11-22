import 'package:blog_app/src/lib/features/app/api_config.dart';
import 'package:blog_app/src/lib/features/hilo/data/dio_hilos.repository.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../domain/iauth_repository.dart';

class DioAuthRepository implements IAuthRepository {
  final Dio dio = GetIt.I.get();

  @override
  Future<Either<Failure, String>> login({
    required String usuario,
    required String password,
  }) async {
    try {
      Response response = await dio.post(
        "/api/auth/login",
        data: {
          "username": usuario,
          "password": password,
        },
      );

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return Right(response.data["token"]);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, String>> registro({
    required String usuario,
    required String password,
  }) async {
    try {
      Response response = await dio.post(
        "/api/auth/registro",
        data: {
          "username": usuario,
          "password": password,
        },
      );

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return Right(response.data["value"]);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }
}
