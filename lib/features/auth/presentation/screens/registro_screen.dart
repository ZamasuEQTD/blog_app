import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/inputs/decorations/decorations.dart';
import '../widgets/auth_btn.dart';
import '../widgets/password_field.dart';
import '../widgets/styles/auth_label_style.dart';

class RegistroScreen extends StatelessWidget {
  const RegistroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      const Text(
        "¡Bienvenido de nuevo!",
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
        onChanged: (value) => context.read(),
        decoration: FlatInputDecoration(hintText: "Usuario"),
      ),
      PasswordField(
          onChanged: (value) => context.read(), hintText: "Contraseña"),
      PasswordField(
          onChanged: (value) => context.read(), hintText: "Repite Contraseña"),
      AuthBtn(texto: "Registrarse", onPressed: () => context.read())
    ]));
  }
}
