import 'package:blog_app/src/lib/features/hilo/presentation/logic/controllers/ver_hilo_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../app/presentation/logic/color_picker.dart';
import '../../../app/presentation/widgets/tag.dart';
import '../../domain/models/comentario.dart';

class TagsDeComentarios extends StatelessWidget {
  const TagsDeComentarios({super.key});

  @override
  Widget build(BuildContext context) {
    final Comentario comentario = context.read();

    return Row(
      children: [
        if (comentario.destacado) const TagDeComentario.destacado(),
        TagDeComentario.rango(rango: comentario.op.rangoCorto.toLowerCase()),
        TagDeComentario.tag(tag: comentario.tag),
        if (comentario.tagUnico != null)
          TagDeComentario.unico(tag: comentario.tagUnico!),
      ]
          .map(
            (x) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              child: x,
            ),
          )
          .toList(),
    );
  }
}

abstract class TagDeComentario extends StatelessWidget {
  const TagDeComentario._({super.key});

  const factory TagDeComentario({
    Key? key,
    TextStyle? style,
    required Color background,
    required String tag,
  }) = _TagDeComentario;

  const factory TagDeComentario.unico({required String tag}) = _TagUnico;

  const factory TagDeComentario.tag({
    required String tag,
  }) = _Tag;

  const factory TagDeComentario.rango({
    required String rango,
  }) = _RangoTag;

  const factory TagDeComentario.destacado() = _DestacadoTag;
}

class _TagDeComentario extends TagDeComentario {
  static const padding = EdgeInsets.symmetric(horizontal: 5, vertical: 2);

  final String tag;
  final Color background;
  final TextStyle? style;
  const _TagDeComentario({
    super.key,
    this.style,
    required this.tag,
    required this.background,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return Tag(
      background: background,
      padding: padding,
      border: BorderRadius.circular(5),
      child: Text(
        tag,
        style: const TextStyle(fontSize: 12).merge(style),
      ),
    );
  }
}

class _Tag extends TagDeComentario {
  final String tag;
  const _Tag({super.key, required this.tag}) : super._();

  @override
  Widget build(BuildContext context) {
    void tagguear() => Get.find<HiloController>().tagguear(tag);

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

class _DestacadoTag extends TagDeComentario {
  const _DestacadoTag() : super._();
  @override
  Widget build(BuildContext context) {
    return const TagDeComentario(
      background: Color.fromRGBO(254, 240, 138, 1),
      tag: "Destacado",
    );
  }
}

class _RangoTag extends TagDeComentario {
  final String rango;

  const _RangoTag({required this.rango}) : super._();

  @override
  Widget build(BuildContext context) {
    return const TagDeComentario(
      background: Colors.white,
      tag: "anon",
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
