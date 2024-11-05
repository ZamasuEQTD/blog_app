import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final String id;
  final String nombre;
  final DateTime registrado;

  const Usuario({
    required this.id,
    required this.nombre,
    required this.registrado,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        nombre: json["nombre"],
        registrado: DateTime.parse(json["registrado"]),
      );

  @override
  List<Object?> get props => [id, nombre, registrado];
}
