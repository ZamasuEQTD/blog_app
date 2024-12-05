import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/app/presentation/logic/extensions/failure_extension.dart';
import 'package:blog_app/features/categorias/domain/models/categoria.dart';
import 'package:blog_app/modules/config/api_config.dart';
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
                    "imagen": ApiConfig.media + e["imagen"],
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
