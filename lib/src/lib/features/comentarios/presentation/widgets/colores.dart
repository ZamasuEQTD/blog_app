import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/presentation/widgets/effects/gradient/animated_gradient.dart';
import '../../domain/models/comentario.dart';

class ColorDeComentario extends StatelessWidget {
  static final HashMap<ColoresDeComentario, Widget> _colores = HashMap.from({
    ColoresDeComentario.amarillo: const ColoredBox(color: Colors.yellow),
    ColoresDeComentario.multi: const MultiColor(),
    ColoresDeComentario.invertido: const MultiInvertido(),
    ColoresDeComentario.rojo: const ColoredBox(color: Colors.red),
  });

  const ColorDeComentario({super.key});

  @override
  Widget build(BuildContext context) {
    final Comentario comentario = context.read();
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
                    comentario.dados ?? comentario.op.rangoCorto,
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
