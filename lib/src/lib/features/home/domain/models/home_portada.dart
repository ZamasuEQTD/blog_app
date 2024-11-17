import 'package:blog_app/src/lib/features/hilo/domain/models/types.dart';
import 'package:equatable/equatable.dart';

import '../../../app/domain/models/spoileable.dart';
import '../../../media/domain/models/media.dart';

class Portada extends Equatable {
  final HiloId id;
  final String titulo;
  final String? autor;
  final String categoria;
  final bool esOp;
  final List<PortadaFeatures> features;
  final Spoileable<Imagen> imagen;
  final DateTime ultimoBump;

  const Portada({
    required this.id,
    required this.titulo,
    this.autor,
    required this.categoria,
    required this.esOp,
    required this.features,
    required this.ultimoBump,
    required this.imagen,
  });

  factory Portada.fromJson(Map<String, dynamic> json) {
    return Portada(
      id: json["id"],
      titulo: json["titulo"],
      autor: json["autor"],
      categoria: json["subcategoria"]["nombre"],
      esOp: json["es_op"],
      features: [
        if (json["es_nuevo"]) PortadaFeatures.nuevo,
        if (json["banderas"]["dados"]) PortadaFeatures.dados,
        if (json["banderas"]["id_unico"]) PortadaFeatures.idUnico,
        if (json["banderas"]["encuesta"]) PortadaFeatures.encuesta,
      ],
      ultimoBump: DateTime.parse(json["ultimo_bump"]),
      imagen: Spoileable<Imagen>(
        json["spoiler"],
        Imagen.fromJson({
          "path": json["miniatura"],
        }),
      ),
    );
  }

  @override
  List<Object?> get props => [
        id,
        titulo,
        categoria,
        features,
        imagen,
        ultimoBump,
      ];
}

typedef PortadaId = String;

enum PortadaFeatures {
  nuevo,
  youtube,
  sticky,
  dados,
  idUnico,
  encuesta,
}

enum HomeRequest { owner }
