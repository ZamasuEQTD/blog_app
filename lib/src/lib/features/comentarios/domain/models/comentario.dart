import 'package:blog_app/features/hilos/domain/models/comentario.dart';

import '../../../app/domain/models/spoileable.dart';
import '../../../media/domain/models/media.dart';

class Comentario {
  final ComentarioId id;
  final String texto;
  final DateTime creado_en;
  final ColoresDeComentario color;
  final DatosDeComentario datos;
  final Autor autor;
  final Spoileable<Media>? media;
  final bool destacado = false;
  final List<String> tags;
  final List<String> taggueos;

  const Comentario({
    required this.id,
    required this.texto,
    required this.creado_en,
    required this.color,
    required this.datos,
    required this.autor,
    required this.media,
    required this.tags,
    required this.taggueos,
  });
}

enum ColoresDeComentario { rojo, amarillo, multi, invertido }
