import 'package:blog_app/features/app/presentation/theme/styles/button_styles.dart';
import 'package:blog_app/features/app/presentation/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/app/presentation/widgets/dialog/widgets/titulo.dart';
import 'package:blog_app/modules/routing.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SesionRequeridaBottomSheet extends StatelessWidget {
  const SesionRequeridaBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet.normal(
      titulo: const DialogTitulo.text(titulo: "Iniciar Sesión Requerido"),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(
          children: [
            const Text(
              "Para acceder a esta función, necesitas iniciar sesión o registrarte si aún no tienes una cuenta.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(108, 117, 125, 1),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.push(Routes.login);
                },
                child: const Text("Iniciar Sesión"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.push(Routes.registro);
                },
                child: const Text("Registrarse"),
              ).withSecondaryStyle(context),
            ),
          ],
        ),
      ),
    );
  }

  static void show(BuildContext context) {
    showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return const SesionRequeridaBottomSheet();
      },
    );
  }
}
