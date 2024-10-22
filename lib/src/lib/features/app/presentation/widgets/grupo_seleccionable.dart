import 'package:flutter/material.dart';

import 'item_seleccionable.dart';

class GrupoSeleccionableSliver extends StatelessWidget {
  final String? titulo;
  final List<Widget> seleccionables;
  const GrupoSeleccionableSliver({
    super.key,
    this.titulo,
    required this.seleccionables,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedSliver(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xffF5F5F5),
      ),
      sliver: SliverMainAxisGroup(
        slivers: [
          if (titulo != null)
            SliverToBoxAdapter(
              child: Text(
                titulo!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          SliverList.builder(
            itemCount: seleccionables.length,
            itemBuilder: (context, index) => seleccionables[index],
          ),
        ],
      ),
    );
  }
}
