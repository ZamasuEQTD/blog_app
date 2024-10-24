import 'package:dartz/dartz.dart';

import '../../../utils/clases/failure.dart';
import 'models/subcategoria.dart';

abstract class ISubcategoriasRepository {
  Future<Either<Failure, List<SubcategoriaEntity>>> getSubcategorias();
}
