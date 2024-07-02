import '../../../shared/models/spoileable.dart';
import '../../media/models/media.dart';
import 'types/hilo_id.dart';

class Hilo {
  final HiloId id;
  final String titulo;
  final String descripcion;
  final DateTime createdAt;
  final BanderasDeHilo banderas;
  final Spoileable<Media> archivo;
  EstadoDeHilo estado;

  Hilo(this.id, this.titulo, this.descripcion, this.createdAt, this.banderas,
      this.estado, this.archivo);

  void cerrarHilo() {
    estado = EstadoDeHilo.eliminado;
  }
}

class BanderasDeHilo {
  final bool dadosActivado;
  final bool idUnicoActivado;
  final bool encuesta;
  const BanderasDeHilo(this.dadosActivado, this.idUnicoActivado, this.encuesta);
}

enum EstadoDeHilo { activo, archivado, eliminado }
