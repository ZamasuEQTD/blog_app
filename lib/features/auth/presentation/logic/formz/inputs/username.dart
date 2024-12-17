import 'package:blog_app/features/app/clases/failure.dart';
import 'package:formz/formz.dart';

import '../../../../domain/failures/auth_failures.dart';

class UsernameInput extends FormzInput<String, Failure> {
  // Call super.pure to represent an unmodified form input.
  const UsernameInput.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const UsernameInput.dirty({String value = ''}) : super.dirty(value);

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
