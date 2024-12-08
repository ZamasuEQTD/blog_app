import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/app/presentation/logic/extensions/failure_extension.dart';
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
        "/auth/login",
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
        "/auth/registro",
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
