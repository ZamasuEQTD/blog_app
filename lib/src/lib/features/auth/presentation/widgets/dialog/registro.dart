import 'package:blog_app/src/lib/features/auth/presentation/blocs/registro/registro_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../app/presentation/widgets/dialogs/dialog.dart';
import '../../../../app/presentation/widgets/dialogs/widgets/button.dart';
import '../../../../app/presentation/widgets/dialogs/widgets/titulo.dart';
import '../../blocs/auth/auth_bloc.dart';
import 'logic/controlls/password_controller.dart';

class RegistroDialog extends StatelessWidget {
  const RegistroDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistroBloc(),
      child: DialogRounded.normal(
        titulo: const DialogTitulo.text(titulo: "Iniciar sesion"),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: "Usuario",
              ),
            ),
            DialogButton.normal(
              onPressed: () => context.read(),
              text: "Registrarse",
            ),
          ]
              .map(
                (e) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<AuthBloc>(),
        child: const RegistroDialog(),
      ),
    );
  }
}

class PasswordObscureButton extends StatelessWidget {
  const PasswordObscureButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
