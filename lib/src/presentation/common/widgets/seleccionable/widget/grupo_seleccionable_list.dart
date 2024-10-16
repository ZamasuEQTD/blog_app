
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
    return ListView.builder(
        shrinkWrap: true,
        controller: controller,
        itemCount: seleccionables.length,
        itemBuilder: (context, index) =>
        _seleccionableSheet(seleccionables[index])
      );
  }

  Widget _seleccionableSheet(GrupoSeleccionable seleccionables) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        seleccionables.nombre != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  seleccionables.nombre!
                ),
              )
            : const SizedBox(),
        ListView.builder(
          controller: controller,
          shrinkWrap: true,
          itemCount: seleccionables.seleccionables.length,
          itemBuilder: (context, index) => _seleccionableTile(seleccionables.seleccionables[index])
        )
      ],
    );
  }

  Widget _seleccionableTile(ItemSeleccionable seleccionable) {
    return ListTile(
      leading: seleccionable.leading,
      trailing: seleccionable.trailing,
      title: Text(
        seleccionable.nombre
      ),
    );
  }
}