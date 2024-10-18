// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:blog_app/common/widgets/effects/blur/blur_effect.dart';
import 'package:blog_app/common/widgets/effects/gradient/gradient_effect.dart';
import 'package:blog_app/common/widgets/media/widgets/image/image_overlapped.dart';
import 'package:blog_app/features/media/presentation/logic/extensions/media_extensions.dart';

import '../../../../../common/widgets/tag/tag.dart';
import '../../../domain/models/home_portada_entry.dart';

abstract class PortadaCard extends StatelessWidget {
  const PortadaCard._({super.key});

  const factory PortadaCard({Key? key, required PortadaEntity portada}) =
      _PortadaCard;

  const factory PortadaCard.cargando({Key? key}) = _PortadaCardCargando;
}

class _PortadaCard extends PortadaCard {
  static const _gradient = [
    Colors.black45,
    Colors.transparent,
    Colors.transparent,
    Colors.black45,
  ];

  static const _stops = [0.0, 0.3, 0.6, 1.0];

  final PortadaEntity portada;

  const _PortadaCard({super.key, required this.portada}) : super._();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        height: 200,
        width: 200,
        child: ImageOverlapped.provider(
          provider: portada.imagen.spoileable.toProvider(),
          boxFit: BoxFit.cover,
          child: Stack(
            children: [
              portada.imagen.esSpoiler ? const BlurEffect() : const SizedBox(),
              GradientEffectWidget(
                colors: _gradient,
                stops: _stops,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PortadaFeatures(
                      portada: portada,
                    ),
                    Text(
                      portada.titulo,
                      maxLines: 2,
                      style: const TituloDePortadaTextStyle(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PortadaFeatures extends StatelessWidget {
  static final HashMap<HomePortadaFeatures, Widget> _features = HashMap.from({
    HomePortadaFeatures.nuevo: const PortadaCardTag.nuevo(),
    HomePortadaFeatures.sticky: const PortadaCardTag.destacado(),
    HomePortadaFeatures.dados: const PortadaCardTag.dados(),
    HomePortadaFeatures.idUnico: const PortadaCardTag.idUnico(),
  });

  final PortadaEntity portada;

  const _PortadaFeatures({super.key, required this.portada});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2,
      runSpacing: 2,
      children: generar(portada)
          .map(
            (w) => SizedBox(
              height: 22,
              child: w,
            ),
          )
          .toList(),
    );
  }

  static List<Widget> generar(PortadaEntity portada) {
    List<Widget> tags = [
      PortadaCardTag.categoria(categoria: portada.categoria),
    ];

    for (var i = 0; i < portada.features.length; i++) {
      Widget child = _features[portada.features[i]]!;

      tags.add(child);
    }

    return tags;
  }
}

class TituloDePortadaTextStyle extends TextStyle {
  const TituloDePortadaTextStyle()
      : super(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          overflow: TextOverflow.ellipsis,
          color: Colors.white,
        );
}

class _PortadaCardCargando extends PortadaCard {
  static final _random = Random();

  const _PortadaCardCargando({
    super.key,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xfff5f5f5),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Bone(
                  height: 20,
                  width: 60,
                  borderRadius: BorderRadius.circular(5),
                ),
                ...List.generate(
                  1 + _random.nextInt(3),
                  (index) => Bone.square(
                    size: 20,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            ),
            const Bone.text(
              words: 1,
              fontSize: 24,
            ),
          ],
        ),
      ),
    );
  }
}

abstract class PortadaCardTag extends StatelessWidget {
  const PortadaCardTag._({super.key});

  const factory PortadaCardTag({
    required Color background,
    required Widget child,
    Key? key,
    required EdgeInsets padding,
  }) = _PortadaCardTag;

  const factory PortadaCardTag.text({
    required Color background,
    required String tag,
  }) = _TextPortadaCardTag;

  const factory PortadaCardTag.categoria({required String categoria}) =
      _CategoriaPortadaCardTag;

  const factory PortadaCardTag.nuevo() = _EsNuevoPortadaCardTag;

  const factory PortadaCardTag.icon({
    required Color background,
    required Widget child,
  }) = _PortadaCardIconTag;

  const factory PortadaCardTag.destacado({Key? key}) =
      _PortadaCardDestacadoIconTag;

  const factory PortadaCardTag.encuesta({Key? key}) =
      _PortadaCardEncuestaIconTag;

  const factory PortadaCardTag.dados({Key? key}) = _PortadaCardDadosIconTag;

  const factory PortadaCardTag.idUnico({Key? key}) = _PortadaCardIdunicoIconTag;
}

class _PortadaCardTag extends PortadaCardTag {
  static const double height = 22;

  final Widget child;
  final Color background;
  final EdgeInsets padding;
  const _PortadaCardTag({
    super.key,
    required this.background,
    required this.child,
    required this.padding,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return Tag(
      background: background,
      height: height,
      padding: padding,
      child: child,
    );
  }
}

class _TextPortadaCardTag extends PortadaCardTag {
  static const EdgeInsets _padding =
      EdgeInsets.symmetric(horizontal: 5, vertical: 2);
  final Color background;
  final String tag;

  const _TextPortadaCardTag({
    required this.background,
    required this.tag,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return PortadaCardTag(
      background: background,
      padding: _padding,
      child: FittedBox(
        child: Text(tag),
      ),
    );
  }
}

class _CategoriaPortadaCardTag extends PortadaCardTag {
  final String categoria;
  const _CategoriaPortadaCardTag({
    required this.categoria,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return PortadaCardTag.text(background: Colors.blue, tag: categoria);
  }
}

class _EsNuevoPortadaCardTag extends PortadaCardTag {
  const _EsNuevoPortadaCardTag({super.key}) : super._();
  @override
  Widget build(BuildContext context) {
    return const PortadaCardTag.text(background: Colors.green, tag: "Nuevo");
  }
}

class _PortadaCardIconTag extends PortadaCardTag {
  static EdgeInsets padding = const EdgeInsets.all(2);

  final Color background;
  final Widget child;

  const _PortadaCardIconTag({
    required this.background,
    required this.child,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return PortadaCardTag(
      background: background,
      padding: padding,
      child: FittedBox(
        child: child,
      ),
    );
  }
}

class _PortadaCardDestacadoIconTag extends PortadaCardTag {
  const _PortadaCardDestacadoIconTag({
    super.key,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return const PortadaCardTag.icon(
      background: Colors.yellow,
      child: Icon(Icons.pin),
    );
  }
}

class _PortadaCardEncuestaIconTag extends PortadaCardTag {
  const _PortadaCardEncuestaIconTag({
    super.key,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return const PortadaCardTag.icon(
      background: Colors.yellow,
      child: Icon(Icons.pin),
    );
  }
}

class _PortadaCardDadosIconTag extends PortadaCardTag {
  const _PortadaCardDadosIconTag({
    super.key,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return const PortadaCardTag.icon(
      background: Colors.yellow,
      child: Icon(Icons.pin),
    );
  }
}

class _PortadaCardIdunicoIconTag extends PortadaCardTag {
  const _PortadaCardIdunicoIconTag({
    super.key,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return const PortadaCardTag.icon(
      background: Colors.yellow,
      child: Icon(Icons.pin),
    );
  }
}
