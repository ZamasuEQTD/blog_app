part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RecuperarUltimaSesion extends AuthEvent {}

class IniciarSesion extends AuthEvent {
  final String usuario;
  final String password;

  const IniciarSesion({required this.usuario, required this.password});
}

class Registrarse extends AuthEvent {
  final String usuario;
  final String password;

  const Registrarse({required this.usuario, required this.password});
}

class CerrarSesion extends AuthEvent {}
