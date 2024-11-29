import 'package:dartz/dartz.dart';

import '../../../utils/clases/failure.dart';
import 'models/categoria.dart';

abstract class ICategoriasRepository {
  Future<Either<Failure, List<Categoria>>> getCategorias();
}
