import 'package:blog_app/features/app/presentation/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/item_seleccionable.dart';
import 'package:blog_app/features/baneos/presentation/screens/banear_usuario_screen.dart';
import 'package:blog_app/features/baneos/presentation/screens/logic/controllers/banear_usuario.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

typedef OnDuracionSeleccionada = void Function(Duracion duracion);

class SeleccionarDuracion extends StatelessWidget {
  final OnDuracionSeleccionada onDuracionSeleccionada;

  const SeleccionarDuracion({super.key, required this.onDuracionSeleccionada});

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet.normal(
      child: Column(
        children: Duracion.values
            .map(
              (e) => GestureDetector(
                onTap: () => {
                  onDuracionSeleccionada(e),
                  context.pop(),
                },
                child: ItemSeleccionable.text(titulo: duraciones[e]!),
              ),
            )
            .toList(),
      ),
    );
  }
}
