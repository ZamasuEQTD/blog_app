
import 'package:blog_app/domain/features/common/entities/spoileable.dart';
import 'package:blog_app/domain/features/media/entities/media.dart';

class Hilo {
  final HiloId id;
  final String titulo;
  final String descripcion;
  final DateTime createdAt;
  final BanderasDeHilo banderas;
  final Spoileable<Media> archivo;
  final EstadoDeHilo estado;

  const Hilo({
    required this.id,
    required this.titulo,
    required this.descripcion,
    required this.createdAt,
    required this.banderas,
    required this.archivo,
    required this.estado
  });

}

class BanderasDeHilo {
  final bool dadosActivado;
  final bool idUnicoActivado;
  final bool encuesta;
  const BanderasDeHilo(this.dadosActivado, this.idUnicoActivado, this.encuesta);
}

enum EstadoDeHilo { activo, archivado, eliminado }

typedef HiloId = String;
