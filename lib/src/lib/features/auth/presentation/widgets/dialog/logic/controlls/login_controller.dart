import 'package:blog_app/src/lib/features/auth/domain/iauth_repository.dart';
import 'package:flash/flash.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../../../../../utils/clases/failure.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  final IAuthRepository repository = GetIt.I.get();

  var usuario = "".obs;
  var password = "".obs;
  var enviando = false.obs;

  Rx<String?> token = Rx(null);

  Rx<Failure?> failure = Rx(null);

  void login() async {
    if (enviando.value) return;

    enviando.value = true;

    var result = await repository.login(
      usuario: usuario.value,
      password: password.value,
    );

    result.fold(
      (l) {
        failure.value = l;
      },
      (r) {
        AuthController controller = Get.find<AuthController>();

        controller.login(r);
      },
    );

    enviando.value = false;
  }
}

class Auths1 extends StatefulWidget {
  const Auths1({super.key});

  @override
  State<Auths1> createState() => _Auths1State();
}

class _Auths1State extends State<Auths1> {
  final controller = Get.put(LoginController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(
        () {
          return Container();
        },
      ),
    );
  }
}
