import 'package:flutter/material.dart';

class ItemSeleccionable {
  final String nombre;
  final TextStyle? style;
  final Widget? leading;
  final Widget? trailing;
  final void Function( )? onTap;
  const ItemSeleccionable({
    required this.nombre,
    this.style,
    this.onTap,
    this.leading,
    this.trailing
  });
}


class DestructibleItem extends ItemSeleccionable{
  DestructibleItem({
    required Color destructiveColor,
    required super.nombre,
    required IconData icon
  }):super(
    style: TextStyle(
      color: destructiveColor
    ),
    leading: Icon(icon,color: destructiveColor)
  );

  factory DestructibleItem.fromContext(BuildContext context, {
    required String nombre,
    required IconData icon
  }) {
    return DestructibleItem(
      destructiveColor: Theme.of(context).colorScheme.error, 
      nombre: nombre,
      icon: icon
    );
  }
}