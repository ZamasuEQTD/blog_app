part of 'registro_bloc.dart';

class RegistroState extends Equatable {
  final String username;
  final String password;
  final String passwordRepetida;
  final RegistroStatus status;
  final Usuario? usuario;
  final Failure? failure;

  const RegistroState({
    this.username ="",
    this.password ="",
    this.passwordRepetida ="",
    this.status = RegistroStatus.initital,
    this.usuario,
    this.failure
  });
  

  RegistroState copyWith({
    String? username,
    String? password,
    String? passwordRepetida,
    RegistroStatus? status,
    Usuario? usuario,
    Failure? failure,
  }){
    return RegistroState(
      username : username?? this.username,
      password : password?? this.password,
      passwordRepetida : passwordRepetida?? this.passwordRepetida,
      status : status?? this.status,
      usuario : usuario?? this.usuario,
      failure : failure?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
    username,
    password,
    passwordRepetida,
    status,
    usuario,
    failure
  ];
}

enum RegistroStatus {
  initital,
  failure,
  registrando,
  registrado
}
