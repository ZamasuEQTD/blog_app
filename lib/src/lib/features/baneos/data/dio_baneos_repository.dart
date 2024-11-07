import 'package:blog_app/src/lib/features/baneos/domain/ibaneos_repository.dart';
import 'package:blog_app/src/lib/features/baneos/presentation/screens/logic/controllers/banear_usuario.dart';
import 'package:blog_app/src/lib/features/hilo/data/dio_hilos.repository.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

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
        "baneos/banear",
        data: {
          "id": id,
          "razon": razon,
          "duracion": duracion,
          "mensaje": mensaje,
        },
      );

      if (response.statusCode != 200) {
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

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      return const Right(unit);
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }
}
