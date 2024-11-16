import 'package:flutter/material.dart';

import 'item_seleccionable.dart';

class GrupoSeleccionableSliver extends StatelessWidget {
  final String? titulo;
  final Color? color;
  final List<Widget> seleccionables;
  const GrupoSeleccionableSliver({
    super.key,
    this.titulo,
    this.color,
    required this.seleccionables,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedSliver(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color ?? Theme.of(context).colorScheme.onSurface,
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

class GrupoSeleccionable extends StatelessWidget {
  final String? titulo;
  final Color? color;
  final List<Widget> seleccionables;

  const GrupoSeleccionable({
    super.key,
    this.titulo,
    this.color,
    required this.seleccionables,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color ?? const Color.fromARGB(255, 255, 255, 255),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: seleccionables,
      ),
    );
  }
}
