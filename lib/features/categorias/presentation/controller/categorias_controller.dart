import 'package:blog_app/features/app/clases/failure.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../domain/isubcategorias_repository.dart';
import '../../domain/models/categoria.dart';

class CategoriasController extends GetxController {
  final Rx<Failure?> failure = Rx<Failure?>(null);

  final Rx<List<Categoria>> categorias = Rx<List<Categoria>>([]);

  final Rx<bool> cargando = Rx<bool>(false);
  CategoriasController();

  Future<void> cargar() async {
    cargando.value = true;

    final ICategoriasRepository repository = GetIt.I.get();

    final res = await repository.getCategorias();

    res.fold(
      (l) => failure.value = l,
      (r) => categorias.value = r,
    );

    cargando.value = false;
  }
}
