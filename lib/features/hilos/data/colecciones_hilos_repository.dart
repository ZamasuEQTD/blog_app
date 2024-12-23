import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/app/presentation/logic/extensions/failure_extension.dart';
import 'package:blog_app/features/colecciones/presentation/logic/controllers/coleccion_controller.dart';
import 'package:blog_app/features/hilos/data/hilo_mapper.dart';
import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../../features/hilos/domain/icolecciones_repository.dart';

class DioColeccionesHilosRepository implements IColeccionesHilosRepository {
  final Dio dio;

  DioColeccionesHilosRepository({required this.dio});

  @override
  Future<Either<Failure, List<PortadaHilo>>> getColeccion({
    required Coleccion coleccion,
    String? ultimo,
  }) async {
    try {
      Response response = await dio.get("colecciones/${coleccion.name}");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      List<Map<String, dynamic>> value = List.from(response.data!["value"]);

      return Right(HilosMapper.fromJsonList(value));
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }
}
