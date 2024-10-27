// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:blog_app/src/lib/features/app/presentation/widgets/bottom_sheet.dart';

class SesionRequeridaButtonsheet extends StatelessWidget {
  const SesionRequeridaButtonsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoundedBottomSheet.normal(
      titulo: Text(
        "Iniciar Sesión Requerido",
        style: TextStyle(
          color: Color.fromRGBO(73, 80, 87, 1),
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            Text(
              "Para acceder a esta función, necesitas iniciar sesión o registrarte si aún no tienes una cuenta.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(108, 117, 125, 1),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SesionRequeridaButton.login(),
            SizedBox(
              height: 10,
            ),
            SesionRequeridaButton.registrarse(),
          ],
        ),
      ),
    );
  }
}

abstract class SesionRequeridaButton extends StatelessWidget {
  const SesionRequeridaButton._({super.key});

  const factory SesionRequeridaButton({
    required Color color,
    required String text,
    TextStyle? style,
    required void Function() onPressed,
  }) = _SesionRequeridaButton;

  const factory SesionRequeridaButton.login() = _IniciarSesionButton;
  const factory SesionRequeridaButton.registrarse() = _RegistrarseButton;
}

class _SesionRequeridaButton extends SesionRequeridaButton {
  final String text;
  final Color color;
  final TextStyle? style;
  final void Function() onPressed;
  const _SesionRequeridaButton({
    required this.text,
    required this.color,
    required this.onPressed,
    this.style,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: const WidgetStatePropertyAll(0.01),
          backgroundColor: WidgetStatePropertyAll(color),
        ),
        onPressed: () {
          context.pop();

          onPressed();
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ).merge(style),
        ),
      ),
    );
  }
}

class _IniciarSesionButton extends SesionRequeridaButton {
  const _IniciarSesionButton({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return SesionRequeridaButton(
      color: const Color(0xff495057),
      text: "Iniciar sesion",
      style: const TextStyle(
        color: Colors.white,
      ),
      onPressed: () {
        context.push("/login");
        log("holaa");
      },
    );
  }
}

class _RegistrarseButton extends SesionRequeridaButton {
  const _RegistrarseButton({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return SesionRequeridaButton(
      color: Colors.white,
      text: "Registrarse",
      onPressed: () {
        context.push("/login");
      },
    );
  }
}
