// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'registro_bloc.dart';

class RegistroState extends Equatable {
  final String username;
  final String password;
  final String passwordRepetida;

  final RegistroFormStatus form;

  const RegistroState({
    this.username = "",
    this.password = "",
    this.passwordRepetida = "",
    this.form = const RegistroFormStatus.initial(),
  });

  @override
  List<Object> get props => [];

  RegistroState copyWith({
    String? username,
    String? password,
    String? passwordRepetida,
    RegistroFormStatus? form,
  }) {
    return RegistroState(
      username: username ?? this.username,
      password: password ?? this.password,
      passwordRepetida: passwordRepetida ?? this.passwordRepetida,
      form: form ?? this.form,
    );
  }
}

abstract class RegistroFormStatus extends Equatable {
  const RegistroFormStatus();

  const factory RegistroFormStatus.initial() = InitialRegistroFormStatus;

  const factory RegistroFormStatus.registrando() =
      RegistrandoRegistroFormStatus;

  const factory RegistroFormStatus.enviado({
    required String token,
  }) = EnviadoRegistroFormStatus;

  const factory RegistroFormStatus.fallido({
    required Failure failure,
  }) = FallidoRegistroFormStatus;

  @override
  List<Object?> get props => [];
}

class InitialRegistroFormStatus extends RegistroFormStatus {
  const InitialRegistroFormStatus();
}

class RegistrandoRegistroFormStatus extends RegistroFormStatus {
  const RegistrandoRegistroFormStatus();
}

class EnviadoRegistroFormStatus extends RegistroFormStatus {
  final String token;
  const EnviadoRegistroFormStatus({
    required this.token,
  });
}

class FallidoRegistroFormStatus extends RegistroFormStatus {
  final Failure failure;

  const FallidoRegistroFormStatus({required this.failure});
}
