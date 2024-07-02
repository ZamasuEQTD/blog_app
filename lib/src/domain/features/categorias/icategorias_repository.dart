
import 'models/categoria.dart';

abstract class ICategoriasRepository {
  Future<List<Categoria>> getCategorias();
}