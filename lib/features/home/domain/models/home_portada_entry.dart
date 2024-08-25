// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/common/logic/classes/spoileable.dart';

import '../../../media/domain/models/media.dart';

abstract class HomePortadaEntry {
  const HomePortadaEntry();
}

class HomePortadaListEntry extends HomePortadaEntry {
  final HomePortadaId id;
  final String titulo;
  final String categoria;
  final List<HomePortadaBanderas> banderas;
  final List<HomePortadaFeatures> features;
  final Spoileable<Imagen> imagen;
  final DateTime ultimoBump;

  const HomePortadaListEntry(
      {required this.id,
      required this.titulo,
      required this.categoria,
      required this.banderas,
      required this.features,
      required this.ultimoBump,
      required this.imagen});
}

class CargandoHomePortadaListEntry extends HomePortadaEntry {}

typedef HomePortadaId = String;

enum HomePortadaFeatures { nuevo, youtube, sticky }

enum HomePortadaBanderas {
  dados,
  idUnico,
}

enum HomeRequest { owner }
