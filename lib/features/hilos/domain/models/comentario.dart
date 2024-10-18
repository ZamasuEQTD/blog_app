// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/common/logic/classes/spoileable.dart';

import '../../../media/domain/models/media.dart';

class ComentarioEntity {
  final ComentarioId id;
  final String texto;
  final DateTime creado_en;
  final ColoresDeComentario color;
  final DatosDeComentario datos;
  final Autor autor;
  final Spoileable<Media>? media;
  final bool destacado = false;
  final List<String> tags = const [">>PEPEPEP"];
  const ComentarioEntity({
    required this.id,
    required this.texto,
    required this.creado_en,
    required this.color,
    required this.datos,
    required this.autor,
    this.media,
  });
}

class DatosDeComentario {
  final String tag;
  final String? tagUnico;
  final String? dados;
  const DatosDeComentario({
    required this.tag,
    required this.tagUnico,
    required this.dados,
  });
}

class Autor {
  final String nombre;
  final String rango;
  final String rangoCorto;
  const Autor({
    required this.nombre,
    required this.rango,
    required this.rangoCorto,
  });
}

typedef ComentarioId = String;

enum ColoresDeComentario { rojo, amarillo, multi, invertido }
