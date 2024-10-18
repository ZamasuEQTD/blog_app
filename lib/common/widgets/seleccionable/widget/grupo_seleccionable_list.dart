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
        color: const Color(0xffF5F5F5),
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

    for (var i = 0; i < grupos.length; i++) {
      Widget child = ItemGrupoSliverList(grupo: grupos[i]);

      if (i != grupos.length - 1) {
        child = SliverPadding(
          padding: const EdgeInsets.only(bottom: 5),
          sliver: child,
        );
      }

      slivers.add(child);
    }

    return slivers;
  }
}
