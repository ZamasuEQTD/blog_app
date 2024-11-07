import 'package:blog_app/src/lib/features/hilo/domain/models/types.dart';
import 'package:equatable/equatable.dart';

import '../../../app/domain/models/spoileable.dart';
import '../../../media/domain/models/media.dart';

class HomePortada extends Equatable {
  final HiloId id;
  final String titulo;
  final String categoria;
  final List<HomePortadaFeatures> features;
  final Spoileable<Imagen> imagen;
  final DateTime ultimoBump;

  const HomePortada({
    required this.id,
    required this.titulo,
    required this.categoria,
    required this.features,
    required this.ultimoBump,
    required this.imagen,
  });

  factory HomePortada.fromJson(Map<String, dynamic> json) {
    return HomePortada(
      id: json["id"],
      titulo: json["titulo"],
      categoria: json["categoria"],
      features: HomePortadaFeatures.values
          .where((e) => json["features"].contains(e.name))
          .toList(),
      ultimoBump: DateTime.parse(json["ultimo_bump"]),
      imagen: Spoileable<Imagen>(
        json["spoiler"],
        Imagen.fromJson(json["media"]),
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

typedef HomePortadaId = String;

enum HomePortadaFeatures {
  nuevo,
  youtube,
  sticky,
  dados,
  idUnico,
}

enum HomeRequest { owner }
