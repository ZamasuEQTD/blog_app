import '../../../app/domain/models/spoileable.dart';
import '../../../categorias/domain/subcategoria.dart';
import '../../../media/domain/models/media.dart';
import 'types.dart';

class Hilo {
  final HiloId id;
  final String titulo;
  final String descripcion;
  final DateTime creadoEn;
  final SubcategoriaEntity categoria;
  final Spoileable<Media> portada;
  final EstadoDeHilo estado;
  final List<BanderasDeHilo> banderas;
  final int comentarios;
  final bool esOp;

  const Hilo({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.creadoEn,
    required this.categoria,
    required this.portada,
    required this.estado,
    required this.banderas,
    required this.comentarios,
    required this.esOp,
  });

  Hilo copyWith({
    HiloId? id,
    String? titulo,
    String? descripcion,
    DateTime? creadoEn,
    SubcategoriaEntity? categoria,
    Spoileable<Media>? portada,
    EstadoDeHilo? estado,
    List<BanderasDeHilo>? banderas,
    int? comentarios,
    bool? esOp,
  }) {
    return Hilo(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      creadoEn: creadoEn ?? this.creadoEn,
      categoria: categoria ?? this.categoria,
      portada: portada ?? this.portada,
      estado: estado ?? this.estado,
      banderas: banderas ?? this.banderas,
      comentarios: comentarios ?? this.comentarios,
      esOp: esOp ?? this.esOp,
    );
  }
}

enum BanderasDeHilo { dados, sticky, encuesta, idUnico }

enum EstadoDeHilo { activo, eliminado, archivado }
