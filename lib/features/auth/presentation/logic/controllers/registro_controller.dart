import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/auth/domain/failures/auth_failures.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../../features/auth/domain/iauth_repository.dart';

class RegistroController extends GetxController {
  final IAuthRepository repository = GetIt.I.get();

  final Rx<RegistroForm> form = RegistroForm().obs;

  Rx<String?> token = Rx(null);
  Rx<Failure?> failure = Rx(null);

  void registrarse() async {
    form.value = form.value.copyWith(status: RegistroState.loading);

    var result = await repository.registro(
      usuario: form.value.username.value,
      password: form.value.password.value,
    );

    result.fold(
      (l) {
        failure.value = l;

        form.value = form.value.copyWith(status: RegistroState.failure);

        form.value = form.value.copyWith(status: RegistroState.initial);
      },
      (r) {
        token.value = r;

        form.value = form.value.copyWith(status: RegistroState.success);
      },
    );
  }
}
