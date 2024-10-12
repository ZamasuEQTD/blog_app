import 'dart:collection';

import 'package:blog_app/common/widgets/effects/gradient/animated_gradient.dart';
import 'package:blog_app/common/widgets/tag/tag.dart';
import 'package:blog_app/features/hilos/domain/models/comentario.dart';
import 'package:blog_app/features/hilos/presentation/logic/bloc/hilo/comentar_hilo/comentar_hilo_bloc.dart';
import 'package:blog_app/features/media/presentation/widgets/media_box/media_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/domain/services/horarios_service.dart';
import '../../../../../../common/logic/services/color_picker.dart';
import '../../../../../../common/widgets/media/widgets/spoiler_media.dart';

class ComentarioCard extends StatelessWidget {
  final ComentarioModel comentario;
  const ComentarioCard({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    _ComentarioColor(comentario: comentario),
                    _ComentarioAutorDatos(comentario: comentario),
                  ],
                ),
                Text(
                  HorariosService.diferencia(
                    utcNow: DateTime.now().toUtc(),
                    time: comentario.creado_en,
                  ).toString(),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          if (comentario.media != null)
            Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: MultiMediaDisplay(
                media: comentario.media!.spoileable,
                dimensionableBuilder: (child) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: MediaSpoileable(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 400,
                          maxWidth: double.infinity,
                        ),
                        child: child,
                      ),
                    ),
                  );
                },
              ),
            ),
          Text(comentario.texto),
        ],
      ),
    );
  }
}

class _ComentarioAutorDatos extends StatelessWidget {
  final ComentarioModel comentario;
  const _ComentarioAutorDatos({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 5),
        Text(
          comentario.autor.nombre,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        _Tags(comentario: comentario),
      ],
    );
  }
}

class _ComentarioColor extends StatelessWidget {
  static final HashMap<ColoresDeComentario, Widget> _colores = HashMap.from({
    ColoresDeComentario.amarillo: const ColoredBox(color: Colors.yellow),
    ColoresDeComentario.multi: const MultiColor(),
    ColoresDeComentario.invertido: const MultiInvertido(),
    ColoresDeComentario.rojo: const ColoredBox(color: Colors.red),
  });

  final ComentarioModel comentario;

  const _ComentarioColor({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        height: 50,
        width: 50,
        child: Stack(
          children: [
            _colores[comentario.color]!,
            Positioned.fill(
              child: Center(
                child: Text(
                  comentario.datos.dados ?? comentario.autor.rangoCorto,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
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

class _TagUnico extends StatelessWidget {
  static final List<Color> _colors = [
    const Color(0xFFdacecd), // dacecd
    const Color(0xFFfddad9), // fddad9
    const Color(0xFFf1d2d5), // f1d2d5
    const Color(0xFFfeebdc), // feebdc
    const Color(0xFFf4f7ef), // f4f7ef
    const Color(0xFFffdcd1), // ffdcd1
    const Color(0xFFbbe7ff), // bbe7ff
    const Color(0xFFccebd9), // ccebd9
    const Color(0xFFf7e8d9), // f7e8d9
    const Color(0xFFffffe5), // ffffe5
  ];

  final String tag;

  const _TagUnico({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Tag.text(
      background: ColorPicker.pickColor(tag, _colors),
      border: BorderRadius.circular(5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: Text(
        tag,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _Tags extends StatelessWidget {
  final ComentarioModel comentario;
  const _Tags({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => tagguear,
          child: Tag.text(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            background: Colors.white,
            child: Text(comentario.datos.tag),
          ),
        ),
        if (comentario.datos.tagUnico != null)
          Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              _TagUnico(tag: comentario.datos.tagUnico!),
            ],
          ),
      ],
    );
  }

  void tagguear(BuildContext context) => context
      .read<ComentarHiloBloc>()
      .add(AggregarTaggueo(tag: comentario.datos.tag));
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
