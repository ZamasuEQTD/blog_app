import 'package:blog_app/features/baneos/domain/models/baneo.dart';
import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final String id;
  final String nombre;
  final DateTime registrado;
  final Baneo? ultimoBaneo;
  const Usuario({
    required this.id,
    required this.nombre,
    required this.registrado,
    this.ultimoBaneo,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
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
