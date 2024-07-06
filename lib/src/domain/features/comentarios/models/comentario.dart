import 'dart:collection';

import 'package:equatable/equatable.dart';

import '../../media/models/media.dart';
import 'types/comentario_id.dart';

class Comentario  {
  final ComentarioId id;
  final String texto;
  final DatosDeComentario datos;
  final DateTime createdAt;
  final Media? media;


  const Comentario({
    required this.id, 
    required this.texto, 
    required this.createdAt,
    required this.datos, 
    required this.media, 
  });
}

class DatosDeComentario {
  final String tag;
  final String? tagUnico;
  final String? dados;
  const DatosDeComentario({
    required this.tag, required this.tagUnico, required this.dados
  });
}
