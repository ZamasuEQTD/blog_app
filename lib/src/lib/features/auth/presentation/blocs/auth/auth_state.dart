part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  const factory AuthState.initial() = AuthInitial;

  const factory AuthState.inciada({
    required Usuario usuario,
  }) = SesionIniciada;

  const factory AuthState.iniciando() = IniciandoSesion;
  const factory AuthState.sinSesion() = SinSesion;

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class SesionIniciada extends AuthState {
  final Usuario usuario;

  const SesionIniciada({required this.usuario});

  @override
  List<Object> get props => [usuario];
}

final class IniciandoSesion extends AuthState {
  const IniciandoSesion();
}

final class SinSesion extends AuthState {
  const SinSesion();
}
