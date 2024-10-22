// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Usuario extends Equatable {
  final String usuario;
  final Rango rango;
  const Usuario({
    required this.usuario,
    required this.rango,
  });
  @override
  List<Object?> get props => throw UnimplementedError();
}

abstract class Rango {
  const Rango();
}

class Moderador extends Rango {
  final String nombre;

  const Moderador({required this.nombre});
}

class Anonimo extends Rango {
  const Anonimo();
}
