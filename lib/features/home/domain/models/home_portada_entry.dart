// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/common/logic/classes/spoileable.dart';

import '../../../media/domain/models/media.dart';

class HomePortadaEntity {
  final HomePortadaId id;
  final String titulo;
  final String categoria;
  final List<HomePortadaFeatures> features;
  final Spoileable<Imagen> imagen;
  final DateTime ultimoBump;

  const HomePortadaEntity({
    required this.id,
    required this.titulo,
    required this.categoria,
    required this.features,
    required this.ultimoBump,
    required this.imagen,
  });
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
