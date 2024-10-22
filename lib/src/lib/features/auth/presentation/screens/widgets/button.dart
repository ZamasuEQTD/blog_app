import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/login/login_bloc.dart';

abstract class AuthButton extends StatelessWidget {
  const AuthButton._({super.key});

  const factory AuthButton({
    Key? key,
    required String label,
    required void Function() onPressed,
  }) = _AuthButton;

  const factory AuthButton.login({
    Key? key,
  }) = _LoginButton;

  const factory AuthButton.registrarse({
    Key? key,
  }) = _RegistrarseButton;
}

class _AuthButton extends AuthButton {
  final String label;
  final void Function() onPressed;

  const _AuthButton({super.key, required this.label, required this.onPressed})
      : super._();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

class _LoginButton extends AuthButton {
  const _LoginButton({
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      onPressed: () => context.read<LoginBloc>().add(Loguearse()),
      label: "Iniciar sesión",
    );
  }
}

class _RegistrarseButton extends AuthButton {
  const _RegistrarseButton({
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return AuthButton(
      onPressed: () => context.read<LoginBloc>().add(Loguearse()),
      label: "Registrarse",
    );
  }
}
