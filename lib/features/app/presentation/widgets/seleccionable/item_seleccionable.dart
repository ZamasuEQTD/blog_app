import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../theme/app_colors.dart';

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

  const factory ItemSeleccionable.checkbox({
    required void Function(bool? value) onChange,
    required String titulo,
    required bool value,
  }) = _CheckboxItem;
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
      onTap: onTap,
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

class _CheckboxItem extends ItemSeleccionable {
  final bool value;
  final String titulo;
  final void Function(bool? value) onChange;
  const _CheckboxItem({
    required this.value,
    required this.titulo,
    required this.onChange,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return ItemSeleccionable.text(
      titulo: titulo,
      trailing: SizedBox(
        height: 20,
        child: SwitchTheme(
          data: const SwitchThemeData(),
          child: Checkbox(
            hoverColor: AppColors.tertiary,
            fillColor: const WidgetStatePropertyAll(AppColors.tertiary),
            checkColor: AppColors.onTertiary,
            value: value,
            onChanged: onChange,
          ),
        ),
      ),
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
