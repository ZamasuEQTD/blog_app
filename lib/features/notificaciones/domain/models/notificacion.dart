import 'package:blog_app/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/features/hilos/domain/models/types.dart';
import 'package:blog_app/features/media/domain/models/media.dart';

typedef NotificacionId = String;

abstract class Notificacion {
  final NotificacionId id;
  final String content;
  final DateTime fecha;
  final ComentarioId comentario;
  final NotificacionHilo hilo;
  const Notificacion({
    required this.id,
    required this.comentario,
    required this.content,
    required this.fecha,
    required this.hilo,
  });
}

class NotificacionHilo {
  final HiloId id;
  final String titulo;
  final Imagen portada;
  const NotificacionHilo({
    required this.id,
    required this.titulo,
    required this.portada,
  });

  factory NotificacionHilo.fromJson(Map<String, dynamic> json) =>
      NotificacionHilo(
        id: json["id"],
        titulo: json["titulo"],
        portada: Imagen.fromJson({
          "url": json["miniatura"],
        }),
      );
}

class HiloComentado extends Notificacion {
  const HiloComentado({
    required super.id,
    required super.hilo,
    required super.comentario,
    required super.content,
    required super.fecha,
  });

  factory HiloComentado.fromJson(Map<String, dynamic> json) => HiloComentado(
        id: json["id"],
        hilo: NotificacionHilo.fromJson(json["hilo"]),
        comentario: json["comentario_id"],
        content: json["contenido"],
        fecha: DateTime.parse(json["fecha"]),
      );
}

class HiloSeguidoComentado extends HiloComentado {
  const HiloSeguidoComentado({
    required super.id,
    required super.hilo,
    required super.comentario,
    required super.content,
    required super.fecha,
  });

  factory HiloSeguidoComentado.fromJson(Map<String, dynamic> json) =>
      HiloSeguidoComentado(
        id: json["id"],
        hilo: NotificacionHilo.fromJson(json["hilo"]),
        comentario: json["comentario"],
        content: json["contenido"],
        fecha: DateTime.parse(json["fecha"]),
      );
}

class ComentarioRespondido extends Notificacion {
  final String respondido;
  const ComentarioRespondido({
    required super.id,
    required super.hilo,
    required super.comentario,
    required super.content,
    required super.fecha,
    required this.respondido,
  });

  factory ComentarioRespondido.fromJson(Map<String, dynamic> json) =>
      ComentarioRespondido(
        id: json["id"],
        hilo: NotificacionHilo.fromJson(json["hilo"]),
        comentario: json["comentario_id"],
        content: json["contenido"],
        fecha: DateTime.parse(json["fecha"]),
        respondido: "gag",
      );
}
