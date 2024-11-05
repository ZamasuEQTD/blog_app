import '../../../hilo/domain/models/types.dart';
import '../../../media/domain/models/media.dart';
import 'registro_de_comentario.dart';

class HiloHistorial extends Historial {
  final String descripcion;
  const HiloHistorial({
    required this.descripcion,
    required super.hilo,
    required super.titulo,
    required super.portada,
    required super.registro,
  });
}
