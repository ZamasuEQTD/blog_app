import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/auth/domain/failures/auth_failures.dart';
import 'package:formz/formz.dart';

class PasswordInput extends FormzInput<String, Failure> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty({String value = ''}) : super.dirty(value);

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
