import 'package:flutter/material.dart';

class ItemSeleccionable {
  final String nombre;
  final TextStyle? style;
  final Widget? leading;
  final Widget? trailing;
  final void Function(BuildContext context)? onTap;
  const ItemSeleccionable({
    required this.nombre,
    this.style,
    this.onTap,
    this.leading,
    this.trailing});
}
