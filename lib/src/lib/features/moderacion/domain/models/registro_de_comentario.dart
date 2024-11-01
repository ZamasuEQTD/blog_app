// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/src/lib/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/src/lib/features/hilo/domain/models/types.dart';

import '../../../media/domain/models/media.dart';

abstract class Historial {
  final HiloId hilo;
  final String titulo;
  final Imagen portada;

  const Historial({
    required this.hilo,
    required this.titulo,
    required this.portada,
  });
}

class HistorialComentario extends Historial {
  final ComentarioId id;
  final String texto;
  final Imagen? imagen;

  const HistorialComentario({
    required this.id,
    required this.texto,
    this.imagen,
    required super.hilo,
    required super.titulo,
    required super.portada,
  });
}
