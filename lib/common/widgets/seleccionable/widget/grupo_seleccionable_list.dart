import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../logic/class/grupo_seleccionable.dart';
import 'list_tile_seleccionable.dart';

class ItemGrupoSliverList extends StatelessWidget {
  final GrupoSeleccionable grupo;
  const ItemGrupoSliverList({super.key, required this.grupo});

  @override
  Widget build(BuildContext context) {
    return DecoratedSliver(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      sliver: SliverMainAxisGroup(
        slivers: [
          grupo.titulo != null
              ? SliverToBoxAdapter(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      grupo.titulo!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                )
              : const SliverToBoxAdapter(),
          SliverList.builder(
            itemCount: grupo.seleccionables.length,
            itemBuilder: (context, index) => ListTileSeleccionable(
              seleccionable: grupo.seleccionables[index],
            ),
          ),
        ],
      ),
    );
  }

  static List<Widget> GenerarSlivers(List<GrupoSeleccionable> grupos) {
    List<Widget> slivers = [];

    for (var grupo in grupos) {
      Widget child = ItemGrupoSliverList(grupo: grupo);
      if (slivers.isNotEmpty) {
        child = SliverPadding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          sliver: child,
        );
      }
      slivers.add(child);
    }

    return slivers;
  }
}
