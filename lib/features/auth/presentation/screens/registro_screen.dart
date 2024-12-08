import 'package:blog_app/features/app/presentation/theme/styles/labels.dart';
import 'package:blog_app/features/app/presentation/widgets/pop.dart';
import 'package:blog_app/features/app/presentation/widgets/snackbars/snackbar.dart';
import 'package:blog_app/features/auth/presentation/logic/controllers/password_controller.dart';
import 'package:blog_app/features/auth/presentation/logic/controllers/registro_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../features/auth/domain/failures/auth_failures.dart';
import '../logic/controllers/auth_controller.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final RegistroController controller = Get.put(RegistroController());

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  final passwordRepetidaController = TextEditingController();

  @override
  void initState() {
    controller.token.listen((value) {
      if (value != null) {
        Get.find<AuthController>().login(value);
      }
    });

    usernameController.addListener(() {
      controller.form.value = controller.form.value.copyWith(
        username: Username.dirty(value: usernameController.text),
      );
    });

    passwordController.addListener(() {
      controller.form.value = controller.form.value.copyWith(
        password: Password.dirty(value: passwordController.text),
      );
    });

    controller.failure.listen((value) {
      if (value != null) {
        Snackbars.showFailure(context, value);
      }
    });

    Get.find<AuthController>().authState.listen((value) {
      if (value == AuthState.authenticated) {
        if (mounted) {
          context.pop();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<RegistroController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopScope(
        canPop: controller.form.value.status != RegistroState.loading,
        child: Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                title: const Text("Registro"),
              ),
              body: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nombre de usuario",
                      style: labelStyle,
                    ),
                    TextFormField(
                      key: const Key("username"),
                      controller: usernameController,
                      decoration: const InputDecoration(
                        hintText: "Usuario",
                      ),
                      validator: (value) => controller.form.value.username
                          .validator(value ?? '')
                          ?.descripcion,
                    ).marginOnly(bottom: 24, top: 8),
                    Text(
                      "Contraseña",
                      style: labelStyle,
                    ),
                    GetBuilder(
                      init: PasswordController(),
                      builder: (controller) => Obx(
                        () => TextField(
                          controller: passwordController,
                          obscureText: controller.obscure.value,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              splashColor: Colors.transparent,
                              onPressed: () => controller.obscure.value =
                                  !controller.obscure.value,
                              icon: Icon(
                                !controller.obscure.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            hintText: "Contraseña",
                          ),
                        ),
                      ),
                    ).marginOnly(bottom: 24, top: 8),
                    Text(
                      "Confirmar contraseña",
                      style: labelStyle,
                    ),
                    GetBuilder(
                      init: PasswordController(),
                      builder: (controller) => Obx(
                        () => TextField(
                          controller: passwordRepetidaController,
                          obscureText: controller.obscure.value,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              splashColor: Colors.transparent,
                              onPressed: () => controller.obscure.value =
                                  !controller.obscure.value,
                              icon: Icon(
                                !controller.obscure.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            hintText: "Repite tu contraseña",
                          ),
                        ),
                      ),
                    ).marginOnly(bottom: 24, top: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: const ButtonStyle(),
                        onPressed: () => controller.registrarse(),
                        child: const Text(
                          "Registrarse",
                        ),
                      ),
                    ),
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "¿Ya tienes una cuenta? ",
                          children: [
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => context.push("/login"),
                              text: "Iniciar sesión",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(73, 80, 87, 1),
                              ),
                            ),
                          ],
                          style: const TextStyle(
                            color: Color.fromRGBO(108, 117, 125, 1),
                          ),
                        ),
                      ).marginOnly(top: 24),
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16),
              ),
            ),
            if (controller.form.value.status == RegistroState.loading)
              const PopScreen(),
          ],
        ),
      ),
    );
  }
}
