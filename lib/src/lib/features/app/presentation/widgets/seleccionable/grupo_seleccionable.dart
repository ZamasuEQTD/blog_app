import 'package:flutter/material.dart';

abstract class GrupoItemSeleccionable extends StatelessWidget {
  const GrupoItemSeleccionable._({super.key});

  const factory GrupoItemSeleccionable.sliver({
    Key? key,
    String? titulo,
    required List<Widget> seleccionables,
  }) = _SliverGrupoSeleccionable;

  const factory GrupoItemSeleccionable({
    Key? key,
    String? titulo,
    required List<Widget> seleccionables,
  }) = _GrupoSeleccionable;
}

class _SliverGrupoSeleccionable extends GrupoItemSeleccionable {
  final String? titulo;
  final List<Widget> seleccionables;
  const _SliverGrupoSeleccionable({
    super.key,
    required this.seleccionables,
    this.titulo,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    Widget? builder(BuildContext context, int index) => seleccionables[index];

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      sliver: DecoratedSliver(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSurface,
          borderRadius: BorderRadius.circular(15),
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
              itemBuilder: builder,
            ),
          ],
        ),
      ),
    );
  }
}

class _GrupoSeleccionable extends GrupoItemSeleccionable {
  final String? titulo;
  final List<Widget> seleccionables;
  const _GrupoSeleccionable(
      {super.key, this.titulo, required this.seleccionables})
      : super._();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          if (titulo != null)
            Text(
              titulo!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ...seleccionables,
        ],
      ),
    );
  }
}
