import 'dart:collection';

import 'package:blog_app/features/app/presentation/widgets/effects/gradient/animated_gradient.dart';
import 'package:blog_app/features/comentarios/domain/models/comentario.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ComentarioColor extends StatelessWidget {
  static final HashMap<ColoresDeComentario, Widget> _colores = HashMap.from({
    ColoresDeComentario.amarillo: const ColoredBox(color: Colors.yellow),
    ColoresDeComentario.multi: const MultiColor(),
    ColoresDeComentario.invertido: const MultiInvertido(),
    ColoresDeComentario.rojo: const ColoredBox(color: Colors.red),
    ColoresDeComentario.azul: const ColoredBox(color: Colors.blue),
    ColoresDeComentario.verde: const ColoredBox(color: Colors.green),
    ColoresDeComentario.black: const ColoredBox(color: Colors.black),
    ColoresDeComentario.white: const ColoredBox(color: Colors.white),
  });

  const ComentarioColor({super.key});

  @override
  Widget build(BuildContext context) {
    final Comentario comentario = context.read();

    final String rango = comentario.detalles.dados ??
        (comentario.esOp ? "OP" : comentario.autor.rango);
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            Positioned.fill(child: _colores[comentario.color]!),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: FittedBox(
                  child: Text(
                    rango,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MultiColor extends LinearGradientAnimation {
  static const List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
  ];

  const MultiColor({super.key}) : super(colors: _colors);
}

class MultiInvertido extends LinearGradientAnimation {
  static const List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
  ];

  const MultiInvertido({super.key}) : super(colors: _colors, reverse: true);
}
