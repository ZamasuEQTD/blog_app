import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemSeleccionable {
  final String nombre;
  final TextStyle? style;
  final Widget? leading;
  final Widget? trailing;
  final void Function()? onTap;
  const ItemSeleccionable(
      {required this.nombre,
      this.style,
      this.onTap,
      this.leading,
      this.trailing});
}

class ItemSeleccionableTileList extends ItemSeleccionable {
  ItemSeleccionableTileList({
    required super.nombre,
    required IconData icon,
  }) : super(leading: Icon(icon));
}

class DestructibleItem extends ItemSeleccionable {
  DestructibleItem(
      {required Color destructiveColor,
      required super.nombre,
      required IconData icon,
      super.onTap})
      : super(
            style: TextStyle(color: destructiveColor),
            leading: Icon(icon, color: destructiveColor));

  factory DestructibleItem.fromContext(BuildContext context,
      {required String nombre, required IconData icon}) {
    return DestructibleItem(
        destructiveColor: Theme.of(context).colorScheme.error,
        nombre: nombre,
        icon: icon);
  }
}

class EliminarItem extends DestructibleItem {
  EliminarItem(
      {required super.destructiveColor, super.nombre = "Eliminar", super.onTap})
      : super(icon: CupertinoIcons.trash);

  factory EliminarItem.fromContext(BuildContext context) {
    return EliminarItem(destructiveColor: Theme.of(context).colorScheme.error);
  }
}

class CheckboxSeleccionableList extends ItemSeleccionable {
  CheckboxSeleccionableList(
      {bool value = false,
      required void Function(bool value) onChange,
      required super.nombre,
      super.style})
      : super(
            onTap: () => onChange(!value),
            trailing: SizedBox(
              height: 20,
              child: SwitchTheme(
                  data: const SwitchThemeData(),
                  child: CupertinoSwitch(
                    value: value,
                    onChanged: onChange,
                  )),
            ));
}
