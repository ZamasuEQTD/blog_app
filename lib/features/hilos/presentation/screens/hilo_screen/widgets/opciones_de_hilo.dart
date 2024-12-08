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
                  usuario: "e4541db1-014d-4355-a1e8-a4647523e2e3",
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
