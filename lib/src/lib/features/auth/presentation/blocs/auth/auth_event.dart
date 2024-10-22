part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class IniciarSesion extends AuthEvent {
  final String token;

  const IniciarSesion({required this.token});
}

class RestaurarSesion extends AuthEvent {}
