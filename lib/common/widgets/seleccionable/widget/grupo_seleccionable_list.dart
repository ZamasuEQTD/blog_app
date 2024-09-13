import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../logic/class/grupo_seleccionable.dart';
import 'list_tile_seleccionable.dart';

class ItemGrupoSliverList extends StatelessWidget {
  final GrupoSeleccionable grupo;
  const ItemGrupoSliverList({super.key, required this.grupo});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      sliver: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: ColoredBox(
          color: Colors.white,
          child: SliverList.builder(
            itemCount: grupo.seleccionables.length,
            itemBuilder: (context, index) => ListTileSeleccionable(
              seleccionable: grupo.seleccionables[index],
            ),
          ),
        ),
      ),
    );
  }

  static List<Widget> GenerarSlivers(List<GrupoSeleccionable> grupos) {
    List<Widget> slivers = [];

    for (var grupo in grupos) {
      slivers.add(ItemGrupoSliverList(grupo: grupo));
    }

    return slivers;
  }
}
