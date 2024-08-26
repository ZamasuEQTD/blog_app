import 'package:blog_app/common/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:blog_app/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import 'package:blog_app/common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OpcionesDePortadaBottomSheet extends StatelessWidget {
  const OpcionesDePortadaBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GrupoSeleccionableList(seleccionables: [
        GrupoSeleccionable(seleccionables: [
          ItemSeleccionableTileList(
              nombre: "Ocultar", icon: FontAwesomeIcons.flag),
          ItemSeleccionableTileList(
              nombre: "Agregar a favoritos", icon: FontAwesomeIcons.flag),
          ItemSeleccionableTileList(
              nombre: "Seguir", icon: FontAwesomeIcons.flag),
          DestructibleItem(
              onTap: () => SeleccionarRazonDeDenuncia.show(
                    context,
                    onSeleccionada: (razon) {},
                  ),
              destructiveColor: Colors.red,
              nombre: "Denunciar",
              icon: FontAwesomeIcons.flag),
        ]),
        GrupoSeleccionable(seleccionables: [
          ItemSeleccionableTileList(
              nombre: "Destacar", icon: FontAwesomeIcons.person),
          ItemSeleccionableTileList(
              nombre: "Ver usuario", icon: FontAwesomeIcons.person),
          DestructibleItem(
              destructiveColor: Colors.red,
              nombre: "Eliminar hilo",
              icon: FontAwesomeIcons.trash)
        ])
      ]),
    );
  }

  static void show(BuildContext context) {
    RoundedBottomSheetManager.show(context,
        child: const OpcionesDePortadaBottomSheet());
  }
}

class SeleccionarRazonDeDenuncia extends StatelessWidget {
  final void Function(OpcioneDeDenuncia razon) onSeleccionada;
  const SeleccionarRazonDeDenuncia({super.key, required this.onSeleccionada});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GrupoSeleccionableList(seleccionables: [
        GrupoSeleccionable(
            seleccionables: OpcioneDeDenuncia.values
                .map<ItemSeleccionable>((e) => ItemSeleccionable(
                      nombre: e.name,
                      onTap: () => onSeleccionada(e),
                    ))
                .toList())
      ]),
    );
  }

  static void show(BuildContext context,
      {required void Function(OpcioneDeDenuncia razon) onSeleccionada}) {
    RoundedBottomSheetManager.show(context,
        child: SeleccionarRazonDeDenuncia(onSeleccionada: onSeleccionada));
  }
}

enum OpcioneDeDenuncia { ilegal, otro }
