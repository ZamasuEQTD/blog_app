import 'package:blog_app/domain/features/common/entities/spoileable.dart';
import 'package:blog_app/domain/features/media/entities/media.dart';

class HomePortadaDeHilo {
  final PortadaHomeId id;
  final String titulo;
  final String subcategoria;
  final DateTime ultimoBump;
  final HomePortadaDeHiloBanderas banderas;
  final Spoileable<Imagen>  portada;
  const HomePortadaDeHilo({
    required this.id, 
    required this.titulo, 
    required this.subcategoria,
    required this.ultimoBump, 
    required this.banderas, 
    required this.portada
  });
}
class HomePortadaDeHiloBanderas {
  final bool esNuevo;

  const HomePortadaDeHiloBanderas({required this.esNuevo});
}


class HomePortadaDeHiloModerador {
  
}

typedef PortadaHomeId = String;
