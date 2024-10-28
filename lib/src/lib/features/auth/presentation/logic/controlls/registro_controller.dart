import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../../../utils/clases/failure.dart';
import '../../../domain/iauth_repository.dart';
import 'auth_controller.dart';

class RegistroController extends GetxController {
  final IAuthRepository repository = GetIt.I.get();

  var usuario = "".obs;
  var password = "".obs;
  var passwordRepetida = "".obs;

  var enviando = false.obs;

  Rx<String?> token = Rx(null);
  Rx<Failure?> failure = Rx(null);

  void registrarse() async {
    enviando.value = true;

    var result = await repository.registro(
      usuario: usuario.value,
      password: password.value,
    );

    result.fold(
      (l) => failure.value = l,
      (r) => Get.find<AuthController>().login(r),
    );

    enviando.value = false;
  }
}
