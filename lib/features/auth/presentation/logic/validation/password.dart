import 'package:blog_app/core/classes/failure.dart';
import 'package:formz/formz.dart';

class Password extends FormzInput<String, Failure> {
  const Password.pure([super.value = ""]) : super.pure();
  const Password.dirty({String value = ''}) : super.dirty(value);
  @override
  Failure? validator(String value) {
    if (value.length > 8) {
      return Failure(code: "El nombre de usuario no puede estar vacio");
    }
    return null;
  }
}
