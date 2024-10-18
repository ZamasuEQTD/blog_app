// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/features/auth/presentation/widgets/bottom_sheet/b.dart';
import 'package:blog_app/features/home/domain/models/home_portada_entry.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class ItemSeleccionable extends StatelessWidget {
  const ItemSeleccionable._({super.key});

  const factory ItemSeleccionable({
    Key? key,
    Widget titulo,
    Widget? leading,
    Widget? trailing,
    void Function()? onTap,
  }) = _ItemSeleccionable;

  const factory ItemSeleccionable.text({
    Widget? leading,
    void Function()? onTap,
    required String titulo,
    TextStyle style,
    Widget? trailing,
  }) = _TextItem;

  const factory ItemSeleccionable.destructible({
    Widget? leading,
    void Function()? onTap,
    required String titulo,
    Widget? trailing,
  }) = _DestructibleItem;
}

class _ItemSeleccionable extends ItemSeleccionable {
  final Widget? titulo;
  final Widget? leading;
  final Widget? trailing;
  final void Function()? onTap;
  const _ItemSeleccionable({
    super.key,
    this.titulo,
    this.leading,
    this.trailing,
    this.onTap,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: titulo,
      leading: leading,
      trailing: trailing,
    );
  }
}

class _TextItem extends ItemSeleccionable {
  final String titulo;
  final Widget? leading;
  final Widget? trailing;
  final TextStyle? style;
  final void Function()? onTap;
  const _TextItem({
    required this.titulo,
    this.leading,
    this.trailing,
    this.style,
    this.onTap,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return ItemSeleccionable(
      titulo: Text(
        titulo,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ).merge(style),
      ),
      trailing: trailing,
      leading: leading,
      onTap: onTap,
    );
  }
}

class _DestructibleItem extends ItemSeleccionable {
  final String titulo;
  final Widget? leading;
  final Widget? trailing;
  final void Function()? onTap;
  const _DestructibleItem({
    required this.titulo,
    this.leading,
    this.trailing,
    this.onTap,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return ItemSeleccionable.text(
      titulo: titulo,
      style: TextStyle(
        color: Theme.of(context).colorScheme.error,
      ),
      leading: leading,
      trailing: trailing,
      onTap: onTap,
    );
  }
}

class EliminarItem extends ItemSeleccionable {
  final void Function()? onTap;
  const EliminarItem({super.key, required this.onTap}) : super._();

  @override
  Widget build(BuildContext context) {
    return ItemSeleccionable.destructible(
      titulo: "Eliminar",
      onTap: onTap,
      leading: ClipOval(
        child: ColoredBox(
          color: Colors.white,
          child: SizedBox(
            height: 40,
            width: 40,
            child: FittedBox(
              child: FaIcon(
                FontAwesomeIcons.trash,
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GrupoSeleccionableSliver extends StatelessWidget {
  final String? titulo;
  final List<ItemSeleccionable> seleccionables;
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

class PortadaOpciones extends StatelessWidget {
  final PortadaEntity portada;
  const PortadaOpciones({super.key, required this.portada});

  @override
  Widget build(BuildContext context) {
    List<Widget> opciones = [
      const GrupoSeleccionableSliver(
        seleccionables: [
          ItemSeleccionable.text(titulo: "Denunciar"),
          ItemSeleccionable.text(titulo: "Ocultar"),
          ItemSeleccionable.text(titulo: "Seguir"),
          ItemSeleccionable.text(titulo: "Poner en favorito"),
        ],
      ),
      GrupoSeleccionableSliver(
        seleccionables: [
          const ItemSeleccionable.text(titulo: "Destacar"),
          const ItemSeleccionable.text(titulo: "Ver usuario"),
          EliminarItem(
            onTap: () {},
          ),
        ],
      ),
    ].addPadding();

    return RoundedBottomSheet.sliver(
      sliver: SliverMainAxisGroup(slivers: opciones),
    );
  }
}

extension GruposSeleccionables on List<GrupoSeleccionableSliver> {
  List<Widget> addPadding() {
    List<Widget> slivers = [];

    for (var i = 0; i < length; i++) {
      Widget child = this[i];

      if (i != length - 1) {
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
