import '../../../hilo/domain/models/types.dart';
import '../../../media/domain/models/media.dart';

class HistorialHilo {
  final HiloId id;
  final String titulo;
  final String descripcion;
  final Imagen portada;

  const HistorialHilo({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.portada,
  });
}
