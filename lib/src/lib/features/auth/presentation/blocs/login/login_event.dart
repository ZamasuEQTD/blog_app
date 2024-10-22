part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class CambiarPassword extends LoginEvent {}

class CambiarUsuario extends LoginEvent {}

class Loguearse extends LoginEvent {}
