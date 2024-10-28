import 'package:blog_app/src/lib/features/auth/presentation/logic/controlls/registro_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../app/presentation/widgets/dialogs/dialog.dart';
import '../../../../app/presentation/widgets/dialogs/widgets/button.dart';
import '../../../../app/presentation/widgets/dialogs/widgets/titulo.dart';

class RegistroDialog extends StatefulWidget {
  const RegistroDialog({super.key});

  @override
  State<RegistroDialog> createState() => _RegistroDialogState();

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const RegistroDialog(),
    );
  }
}

class _RegistroDialogState extends State<RegistroDialog> {
  RegistroController controller = Get.put(RegistroController());

  @override
  Widget build(BuildContext context) {
    return DialogRounded.normal(
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
