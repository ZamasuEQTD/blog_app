// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/features/hilos/domain/models/types.dart';
import 'package:blog_app/features/media/domain/models/media.dart';

import '../../../comentarios/domain/models/typedef.dart';

abstract class Historial {
  final HiloId hilo;
  final String titulo;
  final Imagen portada;
  final DateTime registro;
  const Historial({
    required this.hilo,
    required this.titulo,
    required this.portada,
    required this.registro,
  });
}

class ComentarioHistorial extends Historial {
  final ComentarioId id;
  final String texto;
  final Imagen? imagen;

  const ComentarioHistorial({
    required this.id,
    required this.texto,
    this.imagen,
    required super.hilo,
    required super.titulo,
    required super.portada,
    required super.registro,
  });
}
