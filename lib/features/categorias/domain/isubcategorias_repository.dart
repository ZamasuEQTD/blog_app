import 'package:blog_app/features/app/clases/failure.dart';
import 'package:dartz/dartz.dart';

import 'models/categoria.dart';

abstract class ICategoriasRepository {
  Future<Either<Failure, List<Categoria>>> getCategorias();
}
