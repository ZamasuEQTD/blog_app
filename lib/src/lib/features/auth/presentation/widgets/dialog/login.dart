import 'package:blog_app/src/lib/features/app/presentation/widgets/dialogs/dialog.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/dialogs/widgets/button.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/dialogs/widgets/titulo.dart';
import 'package:blog_app/src/lib/features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:blog_app/src/lib/features/auth/presentation/blocs/login/login_bloc.dart';
import 'package:blog_app/src/lib/features/auth/presentation/widgets/dialog/logic/controlls/login_controller.dart';
import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'logic/controlls/password_controller.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();

  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => BlocProvider.value(
        value: context.read<AuthBloc>(),
        child: const LoginDialog(),
      ),
    );
  }
}

class _LoginDialogState extends State<LoginDialog> {
  final controller = Get.put(LoginController());

  @override
  void initState() {
    controller.failure.listen((value) {
      if (value != null) {
        context.showErrorBar(content: Text(value.code));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (controller) => DialogRounded.normal(
        titulo: const DialogTitulo.text(titulo: "Iniciar sesion"),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: "Usuario",
              ),
            ),
            GetBuilder(
              init: PasswordController(),
              builder: (controller) {
                return TextField(
                  obscureText: controller.obscure.value,
                );
              },
            ),
            DialogButton.normal(
              onPressed: () => context.read(),
              text: "Iniciar sesion",
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
}
