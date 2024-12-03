import 'package:blog_app/features/app/presentation/widgets/snackbars/snackbar.dart';
import 'package:blog_app/features/moderacion/presentation/ver_usuario_panel.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../logic/controllers/auth_controller.dart';
import '../logic/controllers/login_controller.dart';
import '../logic/controllers/password_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());
  final AuthController auth = Get.find<AuthController>();
  @override
  void initState() {
    auth.authState.listen((state) {
      if (state == AuthState.authenticated) {
        context.pop();
      }
    });

    controller.failure.listen(
      (failure) {
        if (failure != null) {
          Snackbars.showFailure(context, failure);
        }
      },
    );

    controller.token.listen(
      (token) {
        if (token != null) {
          auth.login(token);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Iniciar sesión",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nombre de usuario",
            style: context.labelStyle,
          ),
          const TextField(
            decoration: InputDecoration(
              hintText: "Usuario",
            ),
          ).marginOnly(
            bottom: 24,
            top: 8,
          ),
          Text(
            "Contraseña",
            style: context.labelStyle,
          ),
          GetBuilder(
            init: PasswordController(),
            builder: (controller) => Obx(
              () => TextField(
                obscureText: controller.obscure.value,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () =>
                        controller.obscure.value = !controller.obscure.value,
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
          ).marginOnly(
            bottom: 24,
            top: 8,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.login(),
              child: const Text("Iniciar sesión"),
            ),
          ),
          Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: "¿Aun no tienes una cuenta? ",
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => context.push("/registro"),
                    text: "Registrate",
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
      ).paddingSymmetric(horizontal: 24),
    );
  }
}
