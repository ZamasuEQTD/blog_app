// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';

import 'package:blog_app/common/logic/classes/spoileable.dart';
import 'package:blog_app/features/categorias/domain/models/subcategoria.dart';

import '../../../encuestas/domain/models/encuesta.dart';
import '../../../media/domain/models/media.dart';

class Hilo {
  final HiloId id;
  final String titulo;
  final String descripcion;
  final DateTime creadoEn;
  final EstadoDeHilo estado;
  final Subcategoria categoria;
  final Spoileable<Media> portada;
  final Autor autor;
  final Encuesta? encuesta;
  final List<BanderasDeHilo> banderas;
  final int comentarios;
  final bool esOp;
  Hilo({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.creadoEn,
    required this.estado,
    required this.categoria,
    required this.portada,
    required this.autor,
    this.encuesta,
    required this.banderas,
    required this.comentarios,
    required this.esOp,
  });

  Hilo copyWith({
    HiloId? id,
    String? titulo,
    String? descripcion,
    DateTime? creadoEn,
    EstadoDeHilo? estado,
    Subcategoria? categoria,
    Spoileable<Media>? portada,
    Autor? autor,
    Encuesta? encuesta,
    List<BanderasDeHilo>? banderas,
    int? comentarios,
    bool? esOp,
  }) {
    return Hilo(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      creadoEn: creadoEn ?? this.creadoEn,
      estado: estado ?? this.estado,
      categoria: categoria ?? this.categoria,
      portada: portada ?? this.portada,
      autor: autor ?? this.autor,
      encuesta: encuesta ?? this.encuesta,
      banderas: banderas ?? this.banderas,
      comentarios: comentarios ?? this.comentarios,
      esOp: esOp ?? this.esOp,
    );
  }
}

class Autor {
  final String? id;
  final String autor;
  final String rango;

  const Autor({required this.id, required this.autor, required this.rango});
}

typedef HiloId = String;

enum BanderasDeHilo { dados, sticky, encuesta, idUnico }

enum EstadoDeHilo { activo, eliminado, archivado }
