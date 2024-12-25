import 'dart:collection';

import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/app/presentation/logic/extensions/failure_extension.dart';
import 'package:blog_app/features/baneos/domain/ibaneos_repository.dart';
import 'package:blog_app/features/baneos/presentation/screens/logic/controllers/banear_usuario.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:blog_app/features/app/presentation/logic/extensions/response_extension.dart';

class DioBaneosRepository extends IBaneosRepository {
  final Dio dio = GetIt.I.get();

  @override
  Future<Either<Failure, Unit>> banear({
    required String id,
    required Razon razon,
    required Duracion duracion,
    String? mensaje,
  }) async {
    try {
      Response response = await dio.post(
        "/baneos/banear",
        data: {
          "usuario_id": id,
          "razon": razon.index,
          "duracion": duracion.index,
          "mensaje": mensaje,
        },
      );

      if (response.isFailure) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> desbanear({required String id}) async {
    try {
      Response response = await dio.post("baneos/desbanear/$id");

      if (response.isFailure) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }
}
