// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../app/domain/models/spoileable.dart';
import '../../../categorias/domain/models/subcategoria.dart';
import '../../../media/domain/models/media.dart';
import 'types.dart';

class Hilo {
  final HiloId id;
  final String titulo;
  final String descripcion;
  final DateTime creadoEn;
  final Subcategoria categoria;
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
    Subcategoria? categoria,
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

  static Hilo fromJson(Map<String, dynamic> json) {
    return Hilo(
      id: json["id"],
      titulo: json["titulo"],
      descripcion: json["descripcion"],
      creadoEn: DateTime.parse(json["creado_en"]),
      portada: Spoileable<Media>(
        json["portada"]["spoiler"],
        Media.fromJson(
          Map<String, dynamic>.from(json["portada"]["media"] as Map),
        ),
      ),
      estado: EstadoDeHilo.activo,
      banderas: [
        if (json["encuesta"] != null) BanderasDeHilo.encuesta,
        if (json["sticky"] != null) BanderasDeHilo.sticky,
        if (json["banderas"]["id_unico"] != null) BanderasDeHilo.idUnico,
        if (json["banderas"]["dados"] != null) BanderasDeHilo.dados,
      ],
      comentarios: json["cantidad_de_comentarios"],
      esOp: json["es_op"],
      categoria: Subcategoria.fromJson(
        Map<String, dynamic>.from(json["subcategoria"] as Map),
      ),
    );
  }
}

enum BanderasDeHilo { dados, sticky, encuesta, idUnico }

enum EstadoDeHilo { activo, eliminado, archivado }
