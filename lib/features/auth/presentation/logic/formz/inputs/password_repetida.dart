import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/auth/domain/failures/auth_failures.dart';
import 'package:formz/formz.dart';

class ConfirmacionPasswordInput extends FormzInput<String, Failure> {
  final String password;

  const ConfirmacionPasswordInput.pure({
    this.password = "",
  }) : super.pure('');

  const ConfirmacionPasswordInput.dirty({
    this.password = "",
    String value = "",
  }) : super.dirty(value);

  @override
  Failure? validator(String value) {
    if (value != password) {
      return AuthFailures.passwordsNoCoinciden;
    }

    return null;
  }
}
