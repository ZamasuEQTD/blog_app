// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

abstract class DialogRounded extends StatelessWidget {
  const DialogRounded._({super.key});

  const factory DialogRounded({
    required Widget child,
    required BoxConstraints? constraints,
    Key? key,
  }) = _DialogRounded;

  const factory DialogRounded.normal({
    required Widget child,
    BoxConstraints? constraints,
    Widget? titulo,
  }) = _NormalRoundedDialog;
}

class _DialogRounded extends DialogRounded {
  final Widget child;
  final BoxConstraints? constraints;

  const _DialogRounded({
    super.key,
    required this.child,
    required this.constraints,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    Widget child = ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: this.child,
      ),
    );

    if (constraints != null) {
      child = ConstrainedBox(
        constraints: constraints!,
        child: child,
      );
    }

    return child;
  }
}

class _NormalRoundedDialog extends DialogRounded {
  final Widget? titulo;
  final BoxConstraints? constraints;
  final Widget child;

  const _NormalRoundedDialog({
    this.titulo,
    this.constraints,
    required this.child,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return DialogRounded(
      constraints: constraints,
      child: Column(
        children: [
          if (titulo != null) titulo!,
          child,
        ],
      ),
    );
  }
}
