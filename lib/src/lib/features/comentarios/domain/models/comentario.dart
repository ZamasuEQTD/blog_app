// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../app/domain/models/spoileable.dart';
import '../../../media/domain/models/media.dart';
import 'typedef.dart';

class Comentario {
  final ComentarioId id;
  final String texto;
  final DateTime creado_en;
  final ColoresDeComentario color;
  final OpData op;
  final Spoileable<Media>? media;
  final bool destacado = false;
  final String tag;
  final String? autor;
  final String? tagUnico;
  final String? dados;
  final List<String> tags;
  final List<String> taggueos;

  const Comentario({
    required this.id,
    required this.texto,
    required this.creado_en,
    required this.color,
    required this.op,
    required this.tag,
    this.media,
    this.autor,
    this.tagUnico,
    this.dados,
    required this.tags,
    required this.taggueos,
  });
}

enum ColoresDeComentario { rojo, amarillo, multi, invertido }

class OpData {
  final String rango;
  final String rangoCorto;
  final String nombre;
  const OpData({
    required this.nombre,
    required this.rango,
    required this.rangoCorto,
  });
}
