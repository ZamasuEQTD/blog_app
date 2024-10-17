import 'package:blog_app/common/logic/services/color_picker.dart';
import 'package:blog_app/common/widgets/tag/tag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/models/comentario.dart';
import '../../../../logic/bloc/hilo/comentar_hilo/comentar_hilo_bloc.dart';

class TagUnico extends StatelessWidget {
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

  const TagUnico({super.key, required this.tag});

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

class TagsDeComentarios extends StatelessWidget {
  final ComentarioModel comentario;

  const TagsDeComentarios({super.key, required this.comentario});

  @override
  Widget build(BuildContext context) {
    void tagguear() => context.read<ComentarHiloBloc>().add(
          AggregarTaggueo(
            tag: comentario.datos.tag,
          ),
        );

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
              TagUnico(tag: comentario.datos.tagUnico!),
            ],
          ),
      ],
    );
  }
}
