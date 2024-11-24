import 'package:blog_app/src/lib/features/app/api_config.dart';
import 'package:blog_app/src/lib/features/hilo/data/dio_hilos.repository.dart';
import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:blog_app/src/lib/features/moderacion/data/mappers/hilo_mapper.dart';

import 'package:blog_app/src/lib/utils/clases/failure.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../domain/icolecciones_repository.dart';

class DioColeccionesHilosRepository implements IColeccionesHilosRepository {
  final Dio dio;

  DioColeccionesHilosRepository({required this.dio});

  @override
  Future<Either<Failure, List<Portada>>> creados() async {
    try {
      Response response = await dio.get("colecciones/creados");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      List<Map<String, dynamic>> value = List.from(response.data!["value"]);

      return Right(HilosMapper.fromJsonList(value));
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, List<Portada>>> favoritos() async {
    try {
      Response response = await dio.get("colecciones/favoritos");

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      List<Map<String, dynamic>> value = List.from(response.data!["value"]);

      return Right(HilosMapper.fromJsonList(value));
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }

  @override
  Future<Either<Failure, List<Portada>>> seguidos() async {
    try {
      Response response = await dio.get("colecciones/seguidos");

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
