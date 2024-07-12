import 'package:blog_app/src/presentation/common/widgets/bottom_sheet/rounded_bottom_sheet.dart';
import 'package:blog_app/src/presentation/common/widgets/effects/blur/blur_effect.dart';
import 'package:blog_app/src/presentation/common/widgets/effects/blur/blurear_widget.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import 'package:flutter/material.dart';

class OpcionesDePortadaBottomSheet extends StatelessWidget {
  const OpcionesDePortadaBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const BlurearWidget(child: SizedBox(
              height: 200,
              child: Image(
                  image: NetworkImage(
                      "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696")),
            )),
          ),
        ),
        GrupoSeleccionableList(seleccionables: [
          GrupoSeleccionable(seleccionables: [
           ItemSeleccionable(nombre: "Censurar",trailing: Checkbox(value: false, onChanged: (value) {
          },)),
          DestructibleItem.fromContext(context, nombre: "Eliminar", icon: Icons.delete_outline_rounded)
          ])
        ]),
      ],
    );
  }
  static void show(BuildContext context) {
    RoundedBottomSheetManager.show(context: context, child:const OpcionesDePortadaBottomSheet());
  }
}