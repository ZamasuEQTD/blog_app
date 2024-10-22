// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String password;
  final String username;

  final LoginFormStatus form;

  const LoginState({
    this.username = "",
    this.password = "",
    this.form = const LoginFormStatus.initial(),
  });

  @override
  List<Object> get props => [];

  LoginState copyWith({
    String? password,
    String? username,
    LoginFormStatus? form,
  }) {
    return LoginState(
      password: password ?? this.password,
      username: username ?? this.username,
      form: form ?? this.form,
    );
  }
}

abstract class LoginFormStatus extends Equatable {
  const LoginFormStatus();

  const factory LoginFormStatus.initial() = InitialLoginFormStatus;

  const factory LoginFormStatus.enviando() = EnviandoLoginFormStatus;

  const factory LoginFormStatus.enviado({
    required String token,
  }) = EnviadoLoginFormStatus;

  const factory LoginFormStatus.fallido({
    required Failure failure,
  }) = FallidoLoginFormStatus;

  @override
  List<Object?> get props => [];
}

class InitialLoginFormStatus extends LoginFormStatus {
  const InitialLoginFormStatus();
}

class EnviandoLoginFormStatus extends LoginFormStatus {
  const EnviandoLoginFormStatus();
}

class EnviadoLoginFormStatus extends LoginFormStatus {
  final String token;
  const EnviadoLoginFormStatus({
    required this.token,
  });
}

class FallidoLoginFormStatus extends LoginFormStatus {
  final Failure failure;

  const FallidoLoginFormStatus({required this.failure});
}
