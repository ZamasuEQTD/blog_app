// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
  final bool destacado = true;
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
  factory Comentario.fromJson(Map<String, dynamic> json) => Comentario(
        id: json['id'],
        texto: json['texto'],
        creado_en: DateTime.parse(json['creado_en']),
        color: ColoresDeComentario.values.byName(json['color']),
        op: OpData.fromJson(json['op']),
        tag: json['tag'],
        tags: List<String>.from(json['tags']),
        taggueos: List<String>.from(json['taggueos']),
        autor: json['autor'],
        dados: json['dados'],
        tagUnico: json['tag_unico'],
      );
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

  factory OpData.fromJson(Map<String, dynamic> json) => OpData(
        nombre: json['nombre'],
        rango: json['rango'],
        rangoCorto: json['rangoCorto'],
      );
}
