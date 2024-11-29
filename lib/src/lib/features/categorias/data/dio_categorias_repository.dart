import 'package:blog_app/src/lib/features/app/api_config.dart';
import 'package:blog_app/src/lib/features/categorias/domain/models/categoria.dart';
import 'package:blog_app/src/lib/features/hilo/data/dio_hilos.repository.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../domain/isubcategorias_repository.dart';

class DioCategoriasRepository implements ICategoriasRepository {
  final Dio dio = GetIt.I.get();

  @override
  Future<Either<Failure, List<Categoria>>> getCategorias() async {
    try {
      final response = await dio.get('/categorias');

      if (response.statusCode != 200) {
        return Left(response.failure);
      }

      List<Map<String, dynamic>> value = List.from(response.data!["value"]);

      return right(
        value
            .map(
              (e) => Categoria.fromJson({
                ...e,
                "subcategorias": e["subcategorias"].map(
                  (e) => {
                    ...e,
                    "imagen": ApiConfig.api + e["imagen"],
                  },
                ),
              }),
            )
            .toList(),
      );
    } on Exception catch (e) {
      return Left(e.failure);
    }
  }
}
