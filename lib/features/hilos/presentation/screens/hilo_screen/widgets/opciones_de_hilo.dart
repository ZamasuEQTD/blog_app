import 'package:blog_app/features/app/presentation/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/grupo_seleccionable.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/item_seleccionable.dart';
import 'package:blog_app/features/hilos/presentation/widgets/denunciar_hilo/denunciar_hilo.dart';
import 'package:blog_app/features/moderacion/presentation/widgets/usuario_panel/usuario_panel.dart';
import 'package:flutter/material.dart';

class HiloOpciones extends StatelessWidget {
  const HiloOpciones({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet.sliver(
      slivers: [
        GrupoItemSeleccionable.sliver(
          seleccionables: [
            ItemSeleccionable.text(
              titulo: "Denunciar",
              onTap: () {
                DenunciarHiloBottomSheet.show(context);
              },
            ),
          ],
        ),
        if (false)
          const GrupoItemSeleccionable.sliver(
            seleccionables: [
              ItemSeleccionable.text(titulo: "Desactivar notificaciones"),
            ],
          ),
        GrupoItemSeleccionable.sliver(
          seleccionables: [
            ItemSeleccionable.text(
              titulo: "Ver usuario",
              onTap: () {
                UsuarioPanelBottomSheet.show(
                  context,
                  usuario: "27480fac-3bd9-4290-a537-37e07559bb27",
                );
              },
            ),
            const ItemSeleccionable.text(titulo: "Eliminar"),
          ],
        ),
      ],
    );
  }
}
