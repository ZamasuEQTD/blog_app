import 'package:flutter/material.dart';

abstract class AuthTextForm extends StatelessWidget {
  const AuthTextForm._({super.key});

  const factory AuthTextForm({
    required String text,
  }) = _AuthTextForm;

  const factory AuthTextForm.login() = _AuthTextFormLogin;

  const factory AuthTextForm.registro() = _AuthTextFormRegistro;
}

class _AuthTextForm extends AuthTextForm {
  final String text;

  const _AuthTextForm({
    super.key,
    required this.text,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }
}

class _AuthTextFormRegistro extends AuthTextForm {
  const _AuthTextFormRegistro({
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return const AuthTextForm(text: "Informacion de la cuenta");
  }
}

class _AuthTextFormLogin extends AuthTextForm {
  const _AuthTextFormLogin({
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return const AuthTextForm(text: "Informacion de la cuenta");
  }
}
