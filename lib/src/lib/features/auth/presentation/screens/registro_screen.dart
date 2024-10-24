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
        child: const Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                AuthLabel.registro(),
                AuthButton.registrarse(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
