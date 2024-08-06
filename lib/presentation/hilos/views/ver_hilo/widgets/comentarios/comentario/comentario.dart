import 'dart:async';
import 'dart:collection';
import 'dart:developer';

import 'package:blog_app/common/widgets/effects/gradient/animated_gradient.dart';
import 'package:blog_app/domain/features/comentarios/entities/comentario.dart';
import 'package:blog_app/presentation/hilos/views/ver_hilo/logic/bloc/comentar_hilo/comentar_hilo_bloc.dart';
import 'package:blog_app/presentation/hilos/views/ver_hilo/logic/controllers/taggueos_controller.dart';
import 'package:blog_app/presentation/home/widgets/portada/features/tag.dart';
import 'package:blog_app/presentation/home/widgets/portada/features/tags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ComentarioDeHiloWidget extends StatelessWidget {
  final Comentario comentario;
  const ComentarioDeHiloWidget({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InformacionDeAutor(comentario: comentario),
          Text(comentario.texto)
        ],
      ),
    );
  }

  static BoxDecoration _getDecoration() {
    return BoxDecoration(
        color: const Color.fromRGBO(233, 233, 233, 1),
        borderRadius: BorderRadius.circular(15));
  }
}

class InformacionDeAutor extends StatelessWidget {
  final Comentario comentario;

  const InformacionDeAutor({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(children: [
        ColorDeAutorComentario(comentario: comentario),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            comentario.autor.nombre,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        TagDeComentario(comentario: comentario),
        const SizedBox(width: 5),
        _getTagUnico()
      ]),
    );
  }

  Widget _getTagUnico() => comentario.datos.tagUnico != null
      ? TagUnicoDeComentario(comentario.datos.tagUnico!)
      : const SizedBox();
}

class TagDeComentario extends StatelessWidget {
  const TagDeComentario({
    super.key,
    required this.comentario,
  });

  final Comentario comentario;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<TaggueosController>().tagguear(
        texto: context.read<ComentarHiloBloc>().state.texto,
        tag: comentario.datos.tag
      ),
      child: TextTag(
        comentario.datos.tag,
        decoration: TagDeComentarioDecoration(Colors.white),
      ),
    );
  }
}

class TagDeComentarioDecoration extends TextTagDecoration {
  TagDeComentarioDecoration(Color background)
      : super(
            decoration: TagDecoration(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                borderRadius: BorderRadius.circular(15),
                backgroundColor: background));
}

class TagUnicoDeComentario extends TextTag {
  static final List<Color> colors = [Colors.red, Colors.white, Colors.green];

  TagUnicoDeComentario(super.tag, {super.key})
      : super(
            decoration:
                TagDeComentarioDecoration(ColorPicker.pickColor(tag, colors)));
}

class ColorDeAutorComentario extends StatelessWidget {
  final Comentario comentario;
  const ColorDeAutorComentario({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            ColorDeComentario(color: comentario.color),
            Positioned.fill(
              child: Center(
                child: Text(
                  comentario.datos.dados ?? comentario.autor.rangoCorto,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ColorDeComentario extends StatelessWidget {
  final ColoresDeComentario color;
  const ColorDeComentario({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    switch (color) {
      case ColoresDeComentario.rojo:
        return const ColoredBox(color: Colors.red);
      case ColoresDeComentario.multi:
        return const MultiColor();
      default:
        throw ArgumentError("[color] invalido");
    }
  }
}

class MultiColor extends LinearGradientAnimation {
  static const List<Color> multiColors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue
  ];

  const MultiColor({super.key}) : super(colors: multiColors);
}
