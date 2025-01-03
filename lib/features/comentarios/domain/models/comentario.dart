import '../../../app/domain/models/spoileable.dart';
import '../../../media/domain/models/media.dart';
import 'typedef.dart';

class Comentario {
  final ComentarioId id;
  final String texto;
  final DetallesDeComentario detalles;
  final DateTime creado_en;
  final ColoresDeComentario color;
  final Autor autor;
  final ContenidoCensurable<Media>? media;
  final bool esOp;
  final bool destacado;
  final String? autorId;
  final List<String> responde;
  final List<String> respuestas;

  const Comentario({
    required this.id,
    required this.texto,
    required this.creado_en,
    required this.color,
    required this.autor,
    required this.destacado,
    required this.esOp,
    this.media,
    this.autorId,
    required this.detalles,
    required this.responde,
    required this.respuestas,
  });
  factory Comentario.fromJson(Map<String, dynamic> json) => Comentario(
        id: json['id'],
        texto: json['texto'],
        creado_en: DateTime.parse(json['created_at']),
        color: ColoresDeComentario.values.byName(
          (json['color'] as String).toLowerCase(),
        ),
        esOp: json['es_op'],
        destacado: json['destacado'],
        autor: Autor.fromJson(json['autor']),
        detalles: DetallesDeComentario.fromJson(json['detalles']),
        responde: List<String>.from(json['responde']),
        respuestas: List<String>.from(json['respuestas']),
        media: json['media'] != null
            ? ContenidoCensurable.fromJson({
                "spoiler": json['media']['es_spoiler'],
                "ContenidoCensurable": Media.fromJson(json['media']),
              })
            : null,
      );
}

class DetallesDeComentario {
  final String tag;
  final String? dados;
  final String? tagUnico;
  const DetallesDeComentario({
    required this.tag,
    this.dados,
    this.tagUnico,
  });

  factory DetallesDeComentario.fromJson(Map<String, dynamic> json) =>
      DetallesDeComentario(
        tag: json['tag'],
        dados: json['dados'],
        tagUnico: json['tag_unico'],
      );
}

enum ColoresDeComentario {
  rojo,
  amarillo,
  multi,
  invertido,
  azul,
  verde,
  black,
  white
}

class Autor {
  final String rango;
  final String nombre;
  const Autor({
    required this.nombre,
    required this.rango,
  });

  factory Autor.fromJson(Map<String, dynamic> json) => Autor(
        nombre: json['nombre'],
        rango: json['rango'],
      );
}
