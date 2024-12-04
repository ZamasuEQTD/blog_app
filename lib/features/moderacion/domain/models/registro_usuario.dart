import 'package:blog_app/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/features/hilos/domain/models/types.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:equatable/equatable.dart';

import '../../../baneos/domain/models/baneo.dart';

class RegistroUsuario extends Equatable {
  final String id;
  final String nombre;
  final DateTime registrado;
  final Baneo? ultimoBaneo;
  const RegistroUsuario({
    required this.id,
    required this.nombre,
    required this.registrado,
    this.ultimoBaneo,
  });

  factory RegistroUsuario.fromJson(Map<String, dynamic> json) =>
      RegistroUsuario(
        id: json["id"],
        nombre: json["nombre"],
        registrado: DateTime.parse(json["registrado"]),
        ultimoBaneo: json["ultimoBaneo"] != null
            ? Baneo.fromJson(json["ultimoBaneo"])
            : null,
      );

  @override
  List<Object?> get props => [id, nombre, registrado];
}

typedef RegistroId = String;

abstract class Registro {
  final RegistroId id;
  final HiloRegistro hilo;
  final DateTime fecha;
  final String contenido;
  const Registro({
    required this.id,
    required this.hilo,
    required this.fecha,
    required this.contenido,
  });
}

class HiloPosteadoRegistro extends Registro {
  const HiloPosteadoRegistro({
    required super.id,
    required super.hilo,
    required super.fecha,
    required super.contenido,
  });

  factory HiloPosteadoRegistro.fromJson(Map<String, dynamic> json) =>
      HiloPosteadoRegistro(
        id: json["id"],
        hilo: HiloRegistro.fromJson(json["hilo"]),
        fecha: DateTime.parse(json["fecha"]),
        contenido: json["contenido"],
      );
}

class HiloComentadoRegistro extends Registro {
  final ComentarioId comentario;
  final Imagen? imagen;
  const HiloComentadoRegistro({
    required super.id,
    required super.hilo,
    required super.fecha,
    required super.contenido,
    required this.comentario,
    this.imagen,
  });

  factory HiloComentadoRegistro.fromJson(Map<String, dynamic> json) =>
      HiloComentadoRegistro(
        id: json["id"],
        hilo: HiloRegistro.fromJson(json["hilo"]),
        fecha: DateTime.parse(json["fecha"]),
        contenido: json["contenido"],
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
        portada: Imagen.fromJson(json["portada"]),
      );
}
