library auth;

import 'package:formz/formz.dart';

import 'inputs/password.dart';
import 'inputs/password_repetida.dart';
import 'inputs/username.dart';

class RegistroForm with FormzMixin {
  final UsernameInput username;
  final PasswordInput password;
  final ConfirmacionPasswordInput passwordRepetida;
  final RegistroState status;

  RegistroForm({
    this.username = const UsernameInput.pure(),
    this.password = const PasswordInput.pure(),
    this.passwordRepetida = const ConfirmacionPasswordInput.pure(),
    this.status = RegistroState.initial,
  });

  RegistroForm copyWith({
    UsernameInput? username,
    PasswordInput? password,
    ConfirmacionPasswordInput? passwordRepetida,
    RegistroState? status,
  }) =>
      RegistroForm(
        username: username ?? this.username,
        password: password ?? this.password,
        passwordRepetida: passwordRepetida ?? this.passwordRepetida,
        status: status ?? this.status,
      );

  @override
  List<FormzInput> get inputs => [username, password, passwordRepetida];
}

enum RegistroState {
  initial,
  registrando,
  registrado,
  fallido,
}
