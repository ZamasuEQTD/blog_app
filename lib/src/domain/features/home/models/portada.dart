import 'package:blog_app/src/domain/shared/models/spoileable.dart';

import '../../media/models/media.dart';

abstract class Portada {
  const Portada();
}

class CargandoPortadaHome extends Portada{
  const CargandoPortadaHome();
}

class PortadaHome extends Portada {
  final PortadaHomeId id;
  final String titulo;
  final String categoria;
  final PortadaHomeBanderas banderas;
  final Spoileable<Imagen> imagen;
  final DateTime ultimoBump;
  const PortadaHome({
    required this.id, 
    required this.titulo, 
    required this.categoria,
    required this.banderas,
    required this.imagen,
    required this.ultimoBump
  });
}

class PortadaHomeBanderas {
  final bool esNuevo;
  final bool tieneEncuesta;
  final bool dadosActivados;
  final bool idUnicoActivado;
  const PortadaHomeBanderas({
    required this.esNuevo, 
    required this.tieneEncuesta, 
    required this.dadosActivados, 
    required this.idUnicoActivado
  });
}


typedef PortadaHomeId = String;