part of 'registro_bloc.dart';

class RegistroState extends Equatable {
  final FormzSubmissionStatus status;
  final Username usuario;
  final String passwordRepetida;
  final String password;

  const RegistroState(
      {this.status = FormzSubmissionStatus.initial,
      this.usuario = const Username.pure(),
      this.passwordRepetida = "",
      this.password = ""});

  @override
  List<Object> get props => [usuario, passwordRepetida, password];
}
