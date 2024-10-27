import 'dart:developer';
import 'dart:ffi';

import 'package:blog_app/src/lib/features/auth/presentation/screens/widgets/button.dart';
import 'package:blog_app/src/lib/features/auth/presentation/screens/widgets/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/auth/auth_bloc.dart';
import '../blocs/registro/registro_bloc.dart';

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  final RegistroBloc bloc = RegistroBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: BlocListener<RegistroBloc, RegistroState>(
        listener: (context, state) {
          RegistroFormStatus form = state.form;
          if (form is EnviadoRegistroFormStatus) {
            context.read<AuthBloc>().add(IniciarSesion(token: form.token));
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  const AuthLabel.registro(),
                  TextField(
                    onChanged: (value) {
                      log(value);
                    },
                    decoration: const InputDecoration(hintText: "Usuario"),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const TextField(
                    decoration: InputDecoration(hintText: "Contraseña"),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const TextField(
                    decoration: InputDecoration(hintText: "Repite contraseña"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const AuthButton.registrarse(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
