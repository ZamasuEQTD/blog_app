import 'package:flutter/material.dart';

class ItemSeleccionable {
  final String nombre;
  final Widget? leading;
  final Widget? trailing;
  final void Function(BuildContext context)? onTap;
  const ItemSeleccionable({required this.nombre, this.onTap, this.leading, this.trailing});
}