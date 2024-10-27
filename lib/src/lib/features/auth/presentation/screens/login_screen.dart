// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:blog_app/src/lib/features/auth/presentation/screens/widgets/button.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/login/login_bloc.dart';
import 'widgets/label.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginBloc bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocListener<LoginBloc, LoginState>(
        bloc: bloc,
        listener: (context, state) {
          LoginFormStatus form = state.form;
          if (form is EnviadoLoginFormStatus) {
            context.read<AuthBloc>().add(IniciarSesion(token: form.token));
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(
              color: Colors.black,
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AuthLabel.login(),
                  Text(
                    "Informacion de cuenta",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                  TextField(
                    maxLines: 1,
                    onChanged: (value) {
                      log(value);
                    },
                    decoration: const InputDecoration(
                      hintText: "Usuario",
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    maxLines: 1,
                    obscureText: true,
                    onChanged: (value) {
                      log(value);
                    },
                    decoration: InputDecoration(
                      hintText: "Contraseña",
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.remove_red_eye),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const AuthButton.login(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

abstract class AuthInput extends StatelessWidget {
  const AuthInput._({super.key});

  const factory AuthInput({
    required String hintText,
    required bool obscure,
    Widget? suffix,
  }) = _AuthInput;
}

class _AuthInput extends AuthInput {
  final String hintText;
  final Widget? suffix;
  final bool obscure;

  const _AuthInput({
    required this.hintText,
    required this.obscure,
    this.suffix,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: hintText,
        suffix: suffix,
      ),
    );
  }
}

class _UsuarioInput extends AuthInput {
  const _UsuarioInput({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return const AuthInput(
      hintText: "Usuario",
      obscure: false,
    );
  }
}

class _ObscureInput extends AuthInput {
  final Widget? suffix;
  const _ObscureInput({
    this.suffix,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return AuthInput(
      hintText: "Usuario",
      obscure: false,
      suffix: suffix,
    );
  }
}
