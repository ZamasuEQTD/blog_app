
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../logic/class/grupo_seleccionable.dart';
import '../logic/class/item_seleccionable.dart';

class GrupoSeleccionableList extends StatelessWidget {
  final List<GrupoSeleccionable> seleccionables;
  final ScrollController controller;

  const GrupoSeleccionableList._({super.key, required this.seleccionables, required this.controller});

  factory GrupoSeleccionableList({
    required List<GrupoSeleccionable> seleccionables,
    ScrollController? controller,
    Key? key
  }){
    return GrupoSeleccionableList._(
      key: key,
      seleccionables: seleccionables,
      controller: controller?? ScrollController()
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconTheme(data: const IconThemeData(
      color: CupertinoColors.label
    ), child: Padding(
      padding: const EdgeInsets.all(12),
      child: ListView.builder(
          shrinkWrap: true,
          controller: controller,
          itemCount: seleccionables.length,
          itemBuilder: (context, index) =>
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: SeleccionableSheet(
              grupo: seleccionables[index],
              controller: controller
            )
          )
        ),
      )
    );
  }
}


class SeleccionableSheet extends StatelessWidget {
  final GrupoSeleccionable grupo;
  final ScrollController? controller;
  
  const SeleccionableSheet({
    super.key, 
    required this.grupo, 
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            grupo.nombre != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                    child: Text(
                      grupo.nombre!,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  )
                : const SizedBox(),
            ListView.builder(
                controller: controller,
                shrinkWrap: true,
                itemCount: grupo.seleccionables.length,
                itemBuilder: (context, index) => _seleccionableTile(grupo.seleccionables[index])
            )
          ],
        ),
      ),
    );
  }

  Widget _seleccionableTile(ItemSeleccionable seleccionable) {
    return ListTile(
      onTap: seleccionable.onTap,
      leading: seleccionable.leading,
      trailing: seleccionable.trailing,
      title: Text(
        seleccionable.nombre,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ).merge(seleccionable.style),
      ),
    );
  }
}