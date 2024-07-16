import 'package:blog_app/src/presentation/common/widgets/buttons/flat_button.dart';
import 'package:blog_app/src/presentation/common/widgets/inputs/flat_input.dart';
import 'package:blog_app/src/presentation/features/auth/common/widgets/auth_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../common/widgets/password_input.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            CupertinoIcons.chevron_back,
            color: Colors.black
          )
        ),
      ),
      body: const LoginBody()
    );
  }
}

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AuthLabel(text: "¡Bienvenido!"),
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text("Informacion de la cuenta",textAlign: TextAlign.start,style: TextStyle(fontSize: 15),)),
          InputFlatField(hintText: "Usuario"),
          SizedBox(height: 5),
          ObscuredFlatInput(
            hintText: "Contraseña",
          ),
          SizedBox(height: 40),
          ],
        ),
        IniciarSessionButton()
      ],
      ),
    );
  }
}

class IniciarSessionButton extends StatelessWidget {
  const IniciarSessionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 45,
        width: double.infinity,
        child: ElevatedButton(
          style: const NormalButtonStyle(),           
          onPressed: () {
        }, 
        child: const Text("Inciar sesión")
        ),
      ),
    );
  }
}

class NormalButtonStyle extends ButtonStyle {
   const NormalButtonStyle() : super(
    elevation: const WidgetStatePropertyAll(0),
    backgroundColor:  const WidgetStatePropertyAll(Color(0xff5856D6)),
    textStyle: const WidgetStatePropertyAll(
      TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 16
      )
    )
  );
}
