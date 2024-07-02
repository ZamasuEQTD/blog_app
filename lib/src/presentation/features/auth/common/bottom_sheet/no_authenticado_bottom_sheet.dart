import 'package:blog_app/src/presentation/common/widgets/bottom_sheet/rounded_bottom_sheet.dart';
import 'package:blog_app/src/presentation/common/widgets/buttons/flat_button.dart';
import 'package:blog_app/src/presentation/features/auth/common/widgets/auth_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NoAuthenticadoBottomSheet extends StatelessWidget {
  const NoAuthenticadoBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: const Text("Para continuar debes iniciar sesion",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
          SizedBox(
            height: 45,
            child: FlatBtn.text(
              txt: "Iniciar sesión",
              backgroundColor: Colors.white,
            )
          ),
          const SizedBox(height: 10),
          SizedBox(
              height: 45,
              child: FlatBtn.text(
                txt: "Registrarse",
                backgroundColor: Colors.white,
              )),
        ],
      ),
    );
  }
  static void show({
    required BuildContext context
  }) {
    RoundedBottomSheetManager.show(
      context: context, child: const NoAuthenticadoBottomSheet()
    );
  }
}