
import '../../../shared/models/spoileable.dart';
import '../../media/models/media.dart';
import 'types/hilo_id.dart';

class PortadaDeHilo {
  final HiloId id;
  final String titulo;
  final String categoria;
  final BanderasDePortada banderas;
  final Spoileable<Imagen> imagen;
  const PortadaDeHilo(
      this.id, this.titulo, this.categoria, this.banderas, this.imagen
  );
}

class BanderasDePortada {
  final bool esNuevo;
  final bool tieneEncuesta;
  final bool dadosActivados;
  final bool idUnicoActivado;

  const BanderasDePortada({
    required this.esNuevo,
    required this.tieneEncuesta, 
    required this.dadosActivados, 
    required this.idUnicoActivado
  });
}
