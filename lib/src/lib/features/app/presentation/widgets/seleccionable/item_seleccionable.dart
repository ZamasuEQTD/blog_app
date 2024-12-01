import 'package:flutter/material.dart';

abstract class ItemSeleccionable {
  final Widget titulo;
  final Widget? leading;
  final Widget? trailing;
  final void Function()? onTap;

  const ItemSeleccionable({
    required this.titulo,
    this.leading,
    this.trailing,
    this.onTap,
  });
}
