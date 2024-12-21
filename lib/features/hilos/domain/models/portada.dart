import '../../../app/domain/models/spoileable.dart';
import '../../../media/domain/models/media.dart';
import 'types.dart';

class PortadaHilo {
  final HiloId id;
  final String titulo;
  final String? autor;
  final String categoria;
  final bool esOp;
  final List<PortadaFeatures> features;
  final Spoileable<Imagen> imagen;
  final DateTime ultimoBump;

  bool get esSticky => features.contains(PortadaFeatures.sticky);

  const PortadaHilo({
    required this.id,
    required this.titulo,
    required this.autor,
    required this.categoria,
    required this.esOp,
    required this.features,
    required this.imagen,
    required this.ultimoBump,
  });

  factory PortadaHilo.fromJson(Map<String, dynamic> json) {
    return PortadaHilo(
      id: json["id"],
      titulo: json["titulo"],
      autor: json["autor_id"],
      categoria: json["subcategoria"],
      esOp: json["es_op"],
      features: [
        if (json["es_nuevo"]) PortadaFeatures.nuevo,
        if (json["es_sticky"]) PortadaFeatures.sticky,
        if (json["banderas"]["dados_activados"]) PortadaFeatures.dados,
        if (json["banderas"]["id_unico_activado"]) PortadaFeatures.idUnico,
        if (json["banderas"]["tiene_encuesta"]) PortadaFeatures.encuesta,
      ],
      ultimoBump: DateTime.parse(json["ultimo_bump"]),
      imagen: Spoileable<Imagen>(
        json["miniatura"]["es_spoiler"],
        Imagen.fromJson({
          "url": json["miniatura"]["url"],
        }),
      ),
    );
  }
}

enum PortadaFeatures {
  nuevo,
  youtube,
  sticky,
  dados,
  idUnico,
  encuesta,
}
