part of 'login_bloc.dart';

final class LoginState extends Equatable {
  final String username;
  final String password;
  final LoginStatus status;
  final Usuario? usuario;
  final Failure? failure;
  const LoginState({
    this.username = "",
    this.password = "",
    this.status = LoginStatus.initial,
    this.usuario,
    this.failure
  });
  @override
  List<Object?> get props => [
    username,
    password,
    status,
    usuario
  ];

  LoginState copyWith({
    String? username,
    String? password,
    LoginStatus? status,
    Usuario? usuario,
    Failure? failure
  }){
    return LoginState(
      username: username?? this.username,
      password: password?? this.password,
      status: status?? this.status,
      usuario: usuario?? this.usuario,
      failure: failure?? this.failure
    );
  }
}

enum LoginStatus {
  initial,
  failure,
  logueando,
  logueado,
}