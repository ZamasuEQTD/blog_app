import 'package:flutter/material.dart';

import '../../../../../../../common/widgets/bottom_sheet/rounded_bottom_sheet.dart';
import '../../../../../../../common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import '../../../../../../../common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import '../../../../../../../common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';

class ComentarHiloBottomSheet extends StatelessWidget {
  const ComentarHiloBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GrupoSeleccionableList(seleccionables: [
      GrupoSeleccionable(
        nombre: "Agregar media",
        seleccionables: [
        ItemSeleccionable(nombre: "Escoger desde galeria", onTap: ( ) {
          
        },),
        const ItemSeleccionable(nombre: "Agregar Enlace"),
      ])
    ]);
  }


  static void show({
    required BuildContext context
  }){
    RoundedBottomSheetManager.show(context: context, child: const ComentarHiloBottomSheet());
  }
}