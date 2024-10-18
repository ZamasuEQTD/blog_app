// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:blog_app/common/logic/services/color_picker.dart';
import 'package:blog_app/common/widgets/tag/tag.dart';

import '../../../../../../domain/models/comentario.dart';
import '../../../../../logic/bloc/hilo/comentar_hilo/comentar_hilo_bloc.dart';

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
    return Row(
      children: [
        TagDeComentario.tag(tag: comentario.datos.tag),
        if (comentario.datos.tagUnico != null)
          Row(
            children: [
              const SizedBox(
                width: 5,
              ),
              TagDeComentario.unico(tag: comentario.datos.tagUnico!),
            ],
          ),
      ],
    );
  }
}

abstract class TagDeComentario extends StatelessWidget {
  const TagDeComentario._({super.key});

  const factory TagDeComentario({
    required Color background,
    Key? key,
    required String tag,
  }) = _TagDeComentario;

  const factory TagDeComentario.unico({required String tag}) = _TagUnico;

  const factory TagDeComentario.tag({
    required String tag,
  }) = _Tag;
}

class _TagDeComentario extends TagDeComentario {
  static const padding = EdgeInsets.symmetric(horizontal: 5, vertical: 2);

  final String tag;
  final Color background;

  const _TagDeComentario({
    super.key,
    required this.tag,
    required this.background,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return Tag.text(
      background: background,
      padding: padding,
      border: BorderRadius.circular(5),
      child: Text(tag),
    );
  }
}

class _Tag extends TagDeComentario {
  final String tag;
  const _Tag({super.key, required this.tag}) : super._();

  @override
  Widget build(BuildContext context) {
    void tagguear() => context.read<ComentarHiloBloc>().add(
          AggregarTaggueo(
            tag: tag,
          ),
        );

    return GestureDetector(
      onTap: tagguear,
      child: TagDeComentario(
        background: Colors.white,
        tag: tag,
      ),
    );
  }
}

class _TagUnico extends TagDeComentario {
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

  const _TagUnico({
    super.key,
    required this.tag,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return TagDeComentario(
      background: ColorPicker.pickColor(tag, _colors),
      tag: tag,
    );
  }
}
