import 'package:flutter/material.dart';

abstract class AuthLabel extends StatelessWidget {
  const AuthLabel._({super.key});

  const factory AuthLabel({
    required String label,
  }) = _AuthLabel;

  const factory AuthLabel.login() = _LoginLabel;
  const factory AuthLabel.registro() = _RegistroLabel;
}

class _AuthLabel extends AuthLabel {
  final String label;
  const _AuthLabel({
    required this.label,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _LoginLabel extends AuthLabel {
  const _LoginLabel() : super._();

  @override
  Widget build(BuildContext context) {
    return const AuthLabel(label: "¡Bienvenido de nuevo!");
  }
}

class _RegistroLabel extends AuthLabel {
  const _RegistroLabel() : super._();

  @override
  Widget build(BuildContext context) {
    return const AuthLabel(label: "¡Bienvenido de nuevo!");
  }
}
