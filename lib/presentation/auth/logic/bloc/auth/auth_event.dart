part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class IniciarSesion extends AuthEvent {
  final Usuario usuario;

  const IniciarSesion({required this.usuario});
}

class CerrarSesion extends AuthEvent {}