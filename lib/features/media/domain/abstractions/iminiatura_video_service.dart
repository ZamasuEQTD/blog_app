import '../models/media.dart';

abstract class IMiniaturaVideoGenerador {
  Future<Imagen> generar(String path);
}
