
import 'package:blog_app/domain/features/common/entities/spoileable.dart';
import 'package:blog_app/domain/features/media/entities/media.dart';
import 'package:equatable/equatable.dart';

class Hilo extends Equatable {
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
  
  Hilo copyWith({
    HiloId? id,
    String? titulo,
    String? descripcion,
    DateTime? createdAt,
    BanderasDeHilo? banderas,
    Spoileable<Media>? archivo,
    EstadoDeHilo? estado
  }) => Hilo(
    id : id?? this.id,
    titulo : titulo?? this.titulo,
    descripcion : descripcion?? this.descripcion,
    createdAt : createdAt?? this.createdAt,
    banderas : banderas?? this.banderas,
    archivo : archivo?? this.archivo,
    estado : estado?? this.estado,
  );

  @override
  List<Object?> get props => [
    id,
    titulo,
    descripcion,
    createdAt,
    banderas,
    archivo,
    estado
  ];

}

class BanderasDeHilo {
  final bool dadosActivado;
  final bool idUnicoActivado;
  final bool encuesta;
  const BanderasDeHilo(this.dadosActivado, this.idUnicoActivado, this.encuesta);
}

enum EstadoDeHilo { activo, archivado, eliminado }

typedef HiloId = String;
