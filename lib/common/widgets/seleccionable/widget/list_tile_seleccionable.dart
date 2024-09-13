import 'package:flutter/material.dart';

import '../logic/class/item_seleccionable.dart';

class ListTileSeleccionable extends ListTile {
  final ItemSeleccionable seleccionable;

  ListTileSeleccionable({super.key, required this.seleccionable})
      : super(
          onTap: seleccionable.onTap,
          leading: seleccionable.leading,
          trailing: seleccionable.trailing,
          title: Text(
            seleccionable.nombre,
            style: const TextStyle().merge(seleccionable.style),
          ),
        );
}
