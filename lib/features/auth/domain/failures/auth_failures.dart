import 'package:blog_app/features/app/clases/failure.dart';
import 'package:formz/formz.dart';

class AuthFailures {
  const AuthFailures._();

  static Failure get username_vacio => const Failure(
        code: 'username_vacio',
        descripcion: 'El nombre de usuario es requerido',
      );

  static Failure get username_tiene_espacios_vacios => const Failure(
        code: 'username_tiene_espacios_vacios',
        descripcion:
            'El nombre de usuario no puede contener espacios en blanco',
      );

  static Failure get username_longitud_invalida => const Failure(
        code: 'username_longitud_invalida',
        descripcion: 'El nombre de usuario debe tener entre 8 y 16 caracteres',
      );

  static Failure get password_vacia => const Failure(
        code: 'password_vacia',
        descripcion: 'La contraseña es requerida',
      );

  static Failure get password_longitud_invalida => const Failure(
        code: 'password_longitud_invalida',
        descripcion: 'La contraseña debe tener entre 8 y 16 caracteres',
      );

  static Failure get password_tiene_espacios_vacios => const Failure(
        code: 'password_tiene_espacios_vacios',
        descripcion: 'La contraseña no puede contener espacios en blanco',
      );

  static Failure get passwords_no_coinciden => const Failure(
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
      return AuthFailures.username_vacio;
    }

    if (value.length < 8 || value.length > 16) {
      return AuthFailures.username_longitud_invalida;
    }

    if (value.tiene_espacios_vacios) {
      return AuthFailures.username_tiene_espacios_vacios;
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
      return AuthFailures.password_vacia;
    }

    if (value.length < 8 || value.length > 16) {
      return AuthFailures.password_longitud_invalida;
    }

    if (value.tiene_espacios_vacios) {
      return AuthFailures.password_tiene_espacios_vacios;
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
      return AuthFailures.passwords_no_coinciden;
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
