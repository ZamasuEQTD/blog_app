part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class SinSesionInciada extends AuthState {}

final class CerrandoSesion extends AuthState {}

final class IniciandoSesion extends AuthState {}

final class SesionIniciada extends AuthState {
  final Token token;
  final Usuario usuario;

  const SesionIniciada({required this.token, required this.usuario});
}
