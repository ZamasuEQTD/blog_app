import 'package:blog_app/src/presentation/common/widgets/buttons/flat_button.dart';
import 'package:blog_app/src/presentation/common/widgets/inputs/flat_input.dart';
import 'package:blog_app/src/presentation/features/auth/common/bottom_sheet/no_authenticado_bottom_sheet.dart';
import 'package:blog_app/src/presentation/features/auth/common/widgets/auth_label.dart';
import 'package:blog_app/src/presentation/features/auth/common/widgets/password_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const AuthLabel(text: "Crea tu cuenta",),
          const SizedBox(height: 10),
          const Column(
            children: [
              InputFlatField(
                hintText: "Usuario",
              ),
              SizedBox(height: 7),
              ObscuredFlatInput(hintText: "Contraseña"),
              SizedBox(height: 7),
              ObscuredFlatInput(hintText: "Repite contraseña",)
            ],
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 20,
              child: TextButton(
                style:const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 1)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.zero))
                  ),
                ),  
                onPressed: () {}, 
                child: const FittedBox(child: Text("Ya tienes cuenta? Inicia sesion",style: TextStyle(color: CupertinoColors.activeBlue))),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 45,
            child: FlatBtn.text(
              onTap: () {
                NoAuthenticadoBottomSheet.show(context: context);
              },
              txt: "Registrarse",
              backgroundColor: const Color(0xff5856D6),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white
              ),
              borderRadius: 5,
            ),
          )
        ],
      ),
    );
  }
}