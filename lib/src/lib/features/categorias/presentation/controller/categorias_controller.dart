import 'package:blog_app/src/lib/features/categorias/domain/isubcategorias_repository.dart';
import 'package:blog_app/src/lib/features/categorias/domain/models/categoria.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class CategoriasController extends GetxController {
  final ICategoriasRepository categoriasRepository = GetIt.I.get();

  final Rx<Failure?> failure = Rx<Failure?>(null);

  final Rx<List<Categoria>> categorias = Rx<List<Categoria>>([]);

  final Rx<bool> cargando = Rx<bool>(false);
  CategoriasController();

  Future<void> cargar() async {
    cargando.value = true;
    final categorias = await categoriasRepository.getCategorias();
    categorias.fold(
      (l) => failure.value = l,
      (r) => this.categorias.value = r,
    );
    cargando.value = false;
  }
}
