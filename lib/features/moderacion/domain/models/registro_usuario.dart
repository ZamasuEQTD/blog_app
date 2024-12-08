import 'package:blog_app/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/features/hilos/domain/models/types.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:equatable/equatable.dart';

import '../../../baneos/domain/models/baneo.dart';

class RegistroUsuario extends Equatable {
  final String id;
  final String nombre;
  final DateTime registradoEn;
  final Baneo? ultimoBaneo;
  const RegistroUsuario({
    required this.id,
    required this.nombre,
    required this.registradoEn,
    this.ultimoBaneo,
  });

  factory RegistroUsuario.fromJson(Map<String, dynamic> json) =>
      RegistroUsuario(
        id: json["id"],
        nombre: json["nombre"],
        registradoEn: DateTime.parse(json["registrado_en"]),
        ultimoBaneo: json["ultimo_baneo"] != null
            ? Baneo.fromJson(json["ultimo_baneo"])
            : null,
      );

  @override
  List<Object?> get props => [id, nombre, registradoEn];
}

typedef RegistroId = String;

abstract class Registro {
  final HiloRegistro hilo;
  final DateTime fecha;
  final String contenido;
  const Registro({
    required this.hilo,
    required this.fecha,
    required this.contenido,
  });
}

class HiloPosteadoRegistro extends Registro {
  const HiloPosteadoRegistro({
    required super.hilo,
    required super.fecha,
    required super.contenido,
  });

  factory HiloPosteadoRegistro.fromJson(Map<String, dynamic> json) =>
      HiloPosteadoRegistro(
        hilo: HiloRegistro.fromJson(Map<String, dynamic>.from(json["hilo"])),
        fecha: DateTime.parse(json["fecha"]),
        contenido: json["contenido"],
      );
}

class HiloComentadoRegistro extends Registro {
  final ComentarioId comentario;
  final Imagen? imagen;
  const HiloComentadoRegistro({
    required super.hilo,
    required super.fecha,
    required super.contenido,
    required this.comentario,
    this.imagen,
  });

  factory HiloComentadoRegistro.fromJson(Map<String, dynamic> json) =>
      HiloComentadoRegistro(
        fecha: DateTime.parse(json["fecha"]),
        contenido: json["contenido"],
        hilo: HiloRegistro.fromJson(json["hilo"]),
        comentario: json["comentario"],
        imagen: json["imagen"] != null ? Imagen.fromJson(json["imagen"]) : null,
      );
}

class HiloRegistro {
  final HiloId id;
  final String titulo;
  final Imagen portada;
  const HiloRegistro({
    required this.id,
    required this.titulo,
    required this.portada,
  });

  factory HiloRegistro.fromJson(Map<String, dynamic> json) => HiloRegistro(
        id: json["id"],
        titulo: json["titulo"],
        portada: Imagen.fromJson({
          "url": json["miniatura"],
        }),
      );
}
