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

  @override
  List<Object?> get props => [id, nombre, registrado];
}
