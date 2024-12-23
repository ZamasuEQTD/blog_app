import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/auth/domain/iauth_repository.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'auth_controller.dart';

class LoginController extends GetxController {
  final IAuthRepository repository = GetIt.I.get();

  var usuario = "".obs;
  var password = "".obs;

  Rx<LoginStatus> status = LoginStatus.initial.obs;

  Rx<String?> token = Rx(null);

  Rx<Failure?> failure = Rx(null);

  void login() async {
    if (status.value == LoginStatus.enviando) return;

    status.value = LoginStatus.enviando;

    var result = await repository.login(
      usuario: usuario.value,
      password: password.value,
    );

    result.fold(
      (l) {
        failure.value = l;

        status.value = LoginStatus.failure;
      },
      (r) async {
        await Get.find<AuthController>().login(r);

        status.value = LoginStatus.success;
      },
    );

    status.value = LoginStatus.initial;
  }
}

enum LoginStatus {
  initial,
  enviando,
  success,
  failure,
}
