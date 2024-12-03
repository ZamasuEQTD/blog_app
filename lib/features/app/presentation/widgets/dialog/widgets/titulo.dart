import 'package:flutter/material.dart';

abstract class DialogTitulo extends StatelessWidget {
  const DialogTitulo._({super.key});

  const factory DialogTitulo({
    required Widget child,
    Key? key,
  }) = _DialogTitulo;

  const factory DialogTitulo.text({
    Key? key,
    required String titulo,
  }) = _TextTitutloBottomSheet;
}

class _DialogTitulo extends DialogTitulo {
  final Widget child;

  const _DialogTitulo({super.key, required this.child}) : super._();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: child,
    );
  }
}

class _TextTitutloBottomSheet extends DialogTitulo {
  final String titulo;

  const _TextTitutloBottomSheet({
    super.key,
    required this.titulo,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return DialogTitulo(
      child: Text(
        titulo,
        style: const DialogTituloTextStyle(
          color: Color.fromRGBO(73, 80, 87, 1),
        ),
      ),
    );
  }
}

class DialogTituloTextStyle extends TextStyle {
  const DialogTituloTextStyle({
    required super.color,
  }) : super(
          fontSize: 24,
          fontWeight: FontWeight.w700,
        );
}
