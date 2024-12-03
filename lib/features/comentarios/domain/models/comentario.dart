import '../../../app/domain/models/spoileable.dart';
import '../../../media/domain/models/media.dart';
import 'typedef.dart';

class Comentario {
  final ComentarioId id;
  final String texto;
  final DateTime creado_en;
  final ColoresDeComentario color;
  final Autor autor;
  final Spoileable<Media>? media;
  final bool destacado;
  final String tag;
  final String? autorId;
  final String? tagUnico;
  final String? dados;
  final List<String> tags;
  final List<String> taggueos;

  const Comentario({
    required this.id,
    required this.texto,
    required this.creado_en,
    required this.color,
    required this.autor,
    required this.tag,
    required this.destacado,
    this.media,
    this.autorId,
    this.tagUnico,
    this.dados,
    required this.tags,
    required this.taggueos,
  });
  factory Comentario.fromJson(Map<String, dynamic> json) => Comentario(
        id: json['id'],
        texto: json['texto'],
        creado_en: DateTime.parse(json['created_at']),
        color: ColoresDeComentario.values.byName(
          (json['color'] as String).toLowerCase(),
        ),
        destacado: json['destacado'],
        autor: Autor.fromJson(json['autor']),
        tag: json['tag'],
        tags: List<String>.from(json['tags']),
        taggueos: List<String>.from(json['taggueos']),
        autorId: json['autor_id'],
        dados: json['dados'],
        tagUnico: json['tag_unico'],
      );
}

enum ColoresDeComentario { rojo, amarillo, multi, invertido, azul }

class Autor {
  final String rango;
  final String rangoCorto;
  final String nombre;
  const Autor({
    required this.nombre,
    required this.rango,
    required this.rangoCorto,
  });

  factory Autor.fromJson(Map<String, dynamic> json) => Autor(
        nombre: json['nombre'],
        rango: json['rango'],
        rangoCorto: json['rango_corto'],
      );
}
