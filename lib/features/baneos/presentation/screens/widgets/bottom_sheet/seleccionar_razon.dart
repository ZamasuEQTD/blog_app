import 'package:blog_app/features/app/presentation/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/item_seleccionable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../banear_usuario_screen.dart';
import '../../logic/controllers/banear_usuario.dart';

typedef OnRazonSeleccionada = void Function(Razon razon);

class SeleccionarRazon extends StatelessWidget {
  final OnRazonSeleccionada onRazonSeleccionada;

  const SeleccionarRazon({super.key, required this.onRazonSeleccionada});

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet.normal(
      child: Column(
        children: Razon.values
            .map(
              (e) => GestureDetector(
                onTap: () {
                  onRazonSeleccionada(e);
                  context.pop();
                },
                child: ItemSeleccionable.text(titulo: razones[e]!),
              ),
            )
            .toList(),
      ),
    );
  }
}
