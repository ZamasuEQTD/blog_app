import 'package:blog_app/features/auth/presentation/widgets/auth_btn.dart';
import 'package:blog_app/features/auth/presentation/widgets/password_field.dart';
import 'package:blog_app/features/auth/presentation/widgets/styles/auth_label_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/inputs/decorations/decorations.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Text(
          "¡Bienvenido!",
          textAlign: TextAlign.center,
          style: AuthLabelTextStyle(),
        ),
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              "Informacion de la cuenta",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 15),
            )),
        TextField(
          decoration: FlatInputDecoration(hintText: "Usuario"),
        ),
        PasswordField(onChanged: (value) {}, hintText: "Contraseña"),
        AuthBtn(texto: "Iniciar sesión", onPressed: () => context.read())
      ]),
    );
  }
}
