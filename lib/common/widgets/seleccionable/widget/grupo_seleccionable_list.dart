
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../logic/class/grupo_seleccionable.dart';
import '../logic/class/item_seleccionable.dart';

class GrupoSeleccionableList extends StatelessWidget {
  final List<GrupoSeleccionable> seleccionables;

  const GrupoSeleccionableList({
    super.key, required this.seleccionables,
  });

  @override
  Widget build(BuildContext context) {
    return IconTheme(data: const IconThemeData(
      color: CupertinoColors.label
    ), child: ListView.builder(
        itemCount: seleccionables.length,
        itemBuilder: (context, index) =>
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: SeleccionableSheet(
            grupo: seleccionables[index],
          )
        )
      )
    );
  }
}

class SeleccionableSheet extends StatelessWidget {
  final GrupoSeleccionable grupo;

  const SeleccionableSheet({
    super.key, 
    required this.grupo, 
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Colors.white,
        child: ListView.builder(
          itemCount: grupo.seleccionables.length,
          itemBuilder: _itemBuilder
        )
      ),
    );
  }

  Widget? _itemBuilder(context, index) => ListTileSeleccionable(
    seleccionable: grupo.seleccionables[index]
  );
}

class ListTileSeleccionable extends ListTile {
  final ItemSeleccionable seleccionable;

  ListTileSeleccionable({
    super.key,
    required this.seleccionable
  }) : super(
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