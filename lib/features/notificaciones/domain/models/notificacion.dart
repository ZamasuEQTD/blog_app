import 'package:blog_app/features/hilos/domain/models/types.dart';
import 'package:blog_app/features/media/domain/models/media.dart';

abstract class Notificacion {
  final NotificacionId id;
  final HiloId hiloId;
  final Imagen portada;
  final String titulo;

  const Notificacion({
    required this.id,
    required this.hiloId,
    required this.portada,
    required this.titulo,
  });
}

class HiloComentado extends Notificacion {
  final String descripcion;
  const HiloComentado({
    required super.id,
    required super.hiloId,
    required super.portada,
    required super.titulo,
    required this.descripcion,
  });
}

class ComentarioRespondido extends Notificacion {
  final String comentario;
  const ComentarioRespondido({
    required super.id,
    required super.hiloId,
    required super.portada,
    required super.titulo,
    required this.comentario,
  });
}

typedef NotificacionId = String;
