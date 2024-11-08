import 'package:blog_app/main.dart';
import 'package:blog_app/src/lib/features/auth/presentation/widgets/sesion_requerida.dart';
import 'package:blog_app/src/lib/features/postear_hilo/presentation/postear_hilo_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: context.newTheme,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Registro"),
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
            ).marginOnly(bottom: 24, top: 8),
            Text(
              "Contraseña",
              style: context.labelStyle,
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: "Contraseña",
              ),
            ).marginOnly(bottom: 24, top: 8),
            Text(
              "Confirmar contraseña",
              style: context.labelStyle,
            ),
            const TextField(
              decoration: InputDecoration(
                hintText: "Repite tu contraseña",
              ),
            ).marginOnly(bottom: 24, top: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  backgroundColor: const WidgetStatePropertyAll(
                    Color.fromRGBO(22, 22, 23, 1),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Registrarse",
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
    );
  }
}

extension TextStyles on BuildContext {
  TextStyle get labelStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(73, 80, 87, 1),
      );
}
