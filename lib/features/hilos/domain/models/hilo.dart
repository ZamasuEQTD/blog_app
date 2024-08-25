// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/common/logic/classes/spoileable.dart';
import 'package:blog_app/features/categorias/domain/models/subcategoria.dart';

import '../../../encuestas/domain/models/encuesta.dart';
import '../../../media/domain/models/media.dart';

class Hilo {
  final HiloId id;
  final String titulo;
  final String descripcion;
  final DateTime creadoEn;
  final EstadoDeHilo estado;
  final Subcategoria categoria;
  final Spoileable<Media> portada;
  final Encuesta? encuesta;
  final List<BanderasDeHilo> banderas;

  Hilo(
      {required this.id,
      required this.titulo,
      required this.descripcion,
      required this.creadoEn,
      required this.estado,
      required this.categoria,
      required this.portada,
      this.encuesta,
      required this.banderas});

  Hilo copyWith({
    HiloId? id,
    String? titulo,
    String? descripcion,
    DateTime? creadoEn,
    EstadoDeHilo? estado,
    Subcategoria? categoria,
    Spoileable<Media>? portada,
    List<BanderasDeHilo>? banderas,
  }) {
    return Hilo(
      id: id ?? this.id,
      titulo: titulo ?? this.titulo,
      descripcion: descripcion ?? this.descripcion,
      creadoEn: creadoEn ?? this.creadoEn,
      estado: estado ?? this.estado,
      categoria: categoria ?? this.categoria,
      portada: portada ?? this.portada,
      banderas: banderas ?? this.banderas,
    );
  }
}

typedef HiloId = String;

enum BanderasDeHilo { dados, sticky, encuesta, idUnico }

enum EstadoDeHilo { activo, eliminado, archivado }
