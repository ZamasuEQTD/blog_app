import 'package:blog_app/common/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class SesionRequeridaBottomsheet extends StatelessWidget {
  const SesionRequeridaBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Center(
            child: Text(
          "Debes iniciar sesión ",
          style: TextStyle(fontSize: 18),
        )),
        IrLoginBtn(),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        IrRegistroBtn()
      ],
    );
  }

  static void show(BuildContext context) => NormalBottomSheet.show(
        context,
        child: const SesionRequeridaBottomsheet(),
        titulo: "Sesion Requerida",
      );
}

class IrLoginBtn extends StatelessWidget {
  const IrLoginBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: const FlatBtnStyle().copyWith(
            backgroundColor: const WidgetStatePropertyAll(Colors.black)),
        onPressed: () => context.push("login"),
        child: const Text("Iniciar sesion"));
  }
}

class IrRegistroBtn extends StatelessWidget {
  const IrRegistroBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: const FlatBtnStyle().copyWith(
            backgroundColor: const WidgetStatePropertyAll(Colors.white)),
        onPressed: () => context.push("registro"),
        child: const Text(
          "Registrarse",
          style: TextStyle(color: Colors.black),
        ));
  }
}

class FlatBtnStyle extends ButtonStyle {
  const FlatBtnStyle()
      : super(
            shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
            padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(vertical: 15)),
            elevation: const WidgetStatePropertyAll(0));
}
