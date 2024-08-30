import 'package:blog_app/core/classes/failure.dart';
import 'package:formz/formz.dart';

class Username extends FormzInput<String, Failure> {
  const Username.pure([super.value = ""]) : super.pure();
  const Username.dirty({String value = ''}) : super.dirty(value);
  @override
  Failure? validator(String value) {
    if (value.length > 8) {
      return Failure(code: "El nombre de usuario no puede estar vacio");
    }
    return null;
  }
}
