import 'package:blog_app/features/app/clases/failure.dart';
import 'package:formz/formz.dart';

class AuthFailures {
  const AuthFailures._();

  static Failure get usernameVacio => const Failure(
        code: 'usernameVacio',
        descripcion: 'El nombre de usuario es requerido',
      );

  static Failure get usernameTieneEspaciosVacios => const Failure(
        code: 'usernameTieneEspaciosVacios',
        descripcion:
            'El nombre de usuario no puede contener espacios en blanco',
      );

  static Failure get usernameLongitudInvalida => const Failure(
        code: 'usernameLongitudInvalida',
        descripcion: 'El nombre de usuario debe tener entre 8 y 16 caracteres',
      );

  static Failure get passwordVacia => const Failure(
        code: 'passwordVacia',
        descripcion: 'La contraseña es requerida',
      );

  static Failure get passwordLongitudInvalida => const Failure(
        code: 'passwordLongitudInvalida',
        descripcion: 'La contraseña debe tener entre 8 y 16 caracteres',
      );

  static Failure get passwordTieneEspaciosVacios => const Failure(
        code: 'passwordTieneEspaciosVacios',
        descripcion: 'La contraseña no puede contener espacios en blanco',
      );

  static Failure get passwordsNoCoinciden => const Failure(
        code: 'passwords_no_coinciden',
        descripcion: 'Las contraseñas no coinciden',
      );

  static Failure get usuario_ya_existente => const Failure(
        code: 'usuario_ya_existente',
        descripcion: 'El usuario ya existe',
      );
}

class RegistroForm with FormzMixin {
  final Username username;
  final Password password;
  final RegistroState status;

  RegistroForm({
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.status = RegistroState.initial,
  });

  RegistroForm copyWith({
    Username? username,
    Password? password,
    RegistroState? status,
  }) =>
      RegistroForm(
        username: username ?? this.username,
        password: password ?? this.password,
        status: status ?? this.status,
      );

  @override
  List<FormzInput> get inputs => [username, password];
}

class Username extends FormzInput<String, Failure> {
  // Call super.pure to represent an unmodified form input.
  const Username.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Username.dirty({String value = ''}) : super.dirty(value);

  // Override validator to handle validating a given input value.
  @override
  Failure? validator(String value) {
    if (value.isEmpty) {
      return AuthFailures.usernameVacio;
    }

    if (value.length < 8 || value.length > 16) {
      return AuthFailures.usernameLongitudInvalida;
    }

    if (value.tiene_espacios_vacios) {
      return AuthFailures.usernameTieneEspaciosVacios;
    }

    return null;
  }
}

class Password extends FormzInput<String, Failure> {
  const Password.pure() : super.pure('');
  const Password.dirty({String value = ''}) : super.dirty(value);

  @override
  Failure? validator(String value) {
    if (value.isEmpty) {
      return AuthFailures.passwordVacia;
    }

    if (value.length < 8 || value.length > 16) {
      return AuthFailures.passwordLongitudInvalida;
    }

    if (value.tiene_espacios_vacios) {
      return AuthFailures.passwordTieneEspaciosVacios;
    }

    return null;
  }
}

class PasswordRepetida extends FormzInput<String, Failure> {
  final Password password;

  const PasswordRepetida.pure({required this.password}) : super.pure('');
  const PasswordRepetida.dirty({required this.password, String value = ''})
      : super.dirty(value);

  @override
  Failure? validator(String value) {
    if (password.isNotValid) {
      return null;
    }

    if (value != password.value) {
      return AuthFailures.passwordsNoCoinciden;
    }

    return null;
  }
}

extension StringExtensions on String {
  bool get tiene_espacios_vacios => contains(' ');
}

enum RegistroState {
  initial,
  loading,
  success,
  failure,
}
