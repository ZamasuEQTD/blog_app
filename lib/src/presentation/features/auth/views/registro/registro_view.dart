import 'package:blog_app/src/presentation/common/widgets/buttons/flat_button.dart';
import 'package:blog_app/src/presentation/common/widgets/inputs/flat_input.dart';
import 'package:blog_app/src/presentation/features/auth/common/bottom_sheet/no_authenticado_bottom_sheet.dart';
import 'package:blog_app/src/presentation/features/auth/common/widgets/auth_label.dart';
import 'package:blog_app/src/presentation/features/auth/common/widgets/password_input.dart';
import 'package:blog_app/src/presentation/features/auth/views/login/login_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistroView extends StatelessWidget {
  const RegistroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const RegistroBody(),
    );
  }
}

class RegistroBody extends StatelessWidget {
  const RegistroBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AuthLabel(text: "Crea tu cuenta",),
          SizedBox(height: 10),
          LoginCampos(),
          SizedBox(height: 5),
          YaTienesCuentaIniciarSesionButton(),
          SizedBox(height: 10),
          RegistrarseButton()
        ],
      ),
    );
  }
}

class LoginCampos extends StatelessWidget {
  const LoginCampos({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        InputFlatField(
          hintText: "Usuario",
        ),
        SizedBox(height: 7),
        ObscuredFlatInput(hintText: "Contraseña"),
        SizedBox(height: 7),
        ObscuredFlatInput(hintText: "Repite contraseña",)
      ],
    );
  }
}

class YaTienesCuentaIniciarSesionButton extends StatelessWidget {
  const YaTienesCuentaIniciarSesionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 20,
        child: TextButton(
          style:const ButtonStyle(
              padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 1)),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.zero))
            ),
          ),  
          onPressed: () {}, 
          child: const FittedBox(child: Text("Ya tienes cuenta? Inicia sesion",style: TextStyle(color: CupertinoColors.activeBlue))),
        ),
      ),
    );
  }
}

class RegistrarseButton extends StatelessWidget {
  const RegistrarseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
      style: const NormalButtonStyle(),
      onPressed: () {
        
      },
      child: const Text("Registrarse")
      )
    );
  }
}