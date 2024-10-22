// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:blog_app/src/lib/features/auth/presentation/screens/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const AuthLabel.login(),
                  RichText(
                    text: const TextSpan(
                      text: "Inicia sesión o",
                      children: [TextSpan(text: "Registrate")],
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      log(value);
                    },
                    decoration: const InputDecoration(
                      hintText: "Usuario",
                    ),
                  ),
                  TextField(
                    onChanged: (value) {
                      log(value);
                    },
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
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
