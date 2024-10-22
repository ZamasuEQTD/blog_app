import 'package:blog_app/features/auth/presentation/widgets/auth_btn.dart';
import 'package:blog_app/features/auth/presentation/widgets/bottom_sheet/sesion_requerida_bottomsheet.dart';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const Text(
                "¡Bienvenido de nuevo!",
                textAlign: TextAlign.center,
                style: AuthLabelTextStyle(),
              ),
              RichText(
                text: const TextSpan(
                  text: "Inicia sesión o",
                  children: [TextSpan(text: "Registrate")],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "Informacion de la cuenta",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              TextField(
                decoration: FlatInputDecoration(hintText: "Usuario"),
              ),
              const SizedBox(height: 15),
              PasswordField(onChanged: (value) {}, hintText: "Contraseña"),
              const SizedBox(height: 10),
              AuthBtn(
                texto: "Iniciar sesión",
                onPressed: () => SesionRequeridaBottomsheet.show(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
