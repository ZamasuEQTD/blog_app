// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/src/lib/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/src/lib/features/hilo/domain/models/types.dart';

import '../../../media/domain/models/media.dart';

class HistorialDeComentario {
  final ComentarioId id;
  final String text;
  final HiloDeComentario hilo;
  final Imagen? imagen;

  const HistorialDeComentario({
    required this.id,
    required this.text,
    required this.hilo,
    this.imagen,
  });
}

class HiloDeComentario {
  final HiloId id;
  final String titulo;
  final Imagen portada;
  const HiloDeComentario({
    required this.id,
    required this.titulo,
    required this.portada,
  });
}
