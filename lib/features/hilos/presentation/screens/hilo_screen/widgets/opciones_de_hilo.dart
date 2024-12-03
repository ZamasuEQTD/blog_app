import 'package:blog_app/features/app/presentation/widgets/dialog/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/grupo_seleccionable.dart';
import 'package:blog_app/features/app/presentation/widgets/seleccionable/item_seleccionable.dart';
import 'package:blog_app/features/hilos/presentation/screens/hilo_screen/logic/controllers/hilo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HiloOpciones extends StatelessWidget {
  const HiloOpciones({super.key});

  @override
  Widget build(BuildContext context) {
    final HiloController controller = Get.find();
    return RoundedBottomSheet.sliver(
      slivers: [
        GrupoItemSeleccionable.sliver(
          seleccionables: [
            ItemSeleccionable.text(
              titulo: "Denunciar",
              onTap: () {},
            ),
          ],
        ),
        if (controller.hilo.value!.esOp)
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
                showMaterialModalBottomSheet(
                  context: context,
                  builder: (context) {
                    //return const VerUsuarioPanel(usuario: "");
                    return const SizedBox();
                  },
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
