import 'package:get_it/get_it.dart';

import '../../features/categorias/data/dio_categorias_repository.dart';
import '../../features/categorias/domain/isubcategorias_repository.dart';

extension CategoriasDependencies on GetIt {
  GetIt addCategorias() {
    registerLazySingleton<ICategoriasRepository>(
      () => DioCategoriasRepository(),
    );
    return this;
  }
}
