import 'dart:collection';
import 'dart:math';

import 'package:blog_app/features/app/presentation/widgets/effects/blur/blur_effect.dart';
import 'package:blog_app/features/app/presentation/widgets/effects/gradient/gradient_effect.dart';
import 'package:blog_app/features/app/presentation/widgets/image_overlapped.dart';
import 'package:blog_app/features/app/presentation/widgets/tag/tag.dart';
import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:blog_app/features/media/presentation/logic/extension/media_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../icons/hilo_icon.dart';

const borderRadius = BorderRadius.all(Radius.circular(10));

class PortadaSkeleton extends StatelessWidget {
  static final _random = Random();

  const PortadaSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ColoredBox(
        color: const Color(0xfff5f5f5),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    ).marginSymmetric(horizontal: 5),
                  ),
                ],
              ),
              const Bone.text(
                words: 1,
                fontSize: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PortadaWidget extends StatelessWidget {
  static const _gradient = [
    Colors.black45,
    Colors.transparent,
    Colors.transparent,
    Colors.black45,
  ];

  static const _stops = [0.0, 0.3, 0.6, 1.0];

  final PortadaHilo portada;

  const PortadaWidget({super.key, required this.portada});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: ImageOverlapped.provider(
        provider: portada.imagen.spoileable.toProvider,
        boxFit: BoxFit.cover,
        child: BlurEffect(
          blurear: portada.imagen.esSpoiler,
          child: Stack(
            children: [
              GradientEffectWidget(
                colors: _gradient,
                stops: _stops,
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PortadaWidgetFeatures(
                        portada: portada,
                      ),
                      Text(
                        portada.titulo,
                        maxLines: 2,
                        style: const TituloDePortadaWidgetTextStyle(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PortadaWidgetFeatures extends StatelessWidget {
  static final HashMap<PortadaFeatures, Widget> _features = HashMap.from({
    PortadaFeatures.nuevo: const PortadaWidgetCardTag.nuevo(),
    PortadaFeatures.sticky: const PortadaWidgetCardTag.destacado(),
    PortadaFeatures.dados: const PortadaWidgetCardTag.dados(),
    PortadaFeatures.idUnico: const PortadaWidgetCardTag.idUnico(),
  });

  final PortadaHilo portada;

  const _PortadaWidgetFeatures({super.key, required this.portada});

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

  static List<Widget> generar(PortadaHilo portada) {
    List<Widget> tags = [
      PortadaWidgetCardTag.categoria(categoria: portada.categoria),
    ];

    for (var i = 0; i < portada.features.length; i++) {
      Widget child = _features[portada.features[i]]!;

      tags.add(child);
    }

    return tags;
  }
}

class TituloDePortadaWidgetTextStyle extends TextStyle {
  const TituloDePortadaWidgetTextStyle()
      : super(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          overflow: TextOverflow.ellipsis,
          color: Colors.white,
        );
}

abstract class PortadaWidgetCardTag extends StatelessWidget {
  const PortadaWidgetCardTag._({super.key});

  const factory PortadaWidgetCardTag({
    Key? key,
    required Color background,
    required EdgeInsets padding,
    required Widget child,
  }) = _PortadaWidgetCardTag;

  const factory PortadaWidgetCardTag.text({
    required Color background,
    required String tag,
  }) = _TextPortadaWidgetCardTag;

  const factory PortadaWidgetCardTag.categoria({required String categoria}) =
      _CategoriaPortadaWidgetCardTag;

  const factory PortadaWidgetCardTag.nuevo() = _EsNuevoPortadaWidgetCardTag;

  const factory PortadaWidgetCardTag.icon({
    Color? background,
    required Widget child,
  }) = _PortadaWidgetCardIconTag;

  const factory PortadaWidgetCardTag.destacado({Key? key}) =
      _PortadaWidgetCardDestacadoIconTag;

  const factory PortadaWidgetCardTag.encuesta({Key? key}) =
      _PortadaWidgetCardEncuestaIconTag;

  const factory PortadaWidgetCardTag.dados({Key? key}) =
      _PortadaWidgetCardDadosIconTag;

  const factory PortadaWidgetCardTag.idUnico({Key? key}) =
      _PortadaWidgetCardIdunicoIconTag;
}

class _PortadaWidgetCardTag extends PortadaWidgetCardTag {
  static const double height = 22;

  final Color background;
  final EdgeInsets padding;
  final Widget child;
  const _PortadaWidgetCardTag({
    super.key,
    required this.background,
    required this.padding,
    required this.child,
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

class _TextPortadaWidgetCardTag extends PortadaWidgetCardTag {
  static const EdgeInsets _padding =
      EdgeInsets.symmetric(horizontal: 5, vertical: 2);
  final Color background;
  final String tag;

  const _TextPortadaWidgetCardTag({
    required this.background,
    required this.tag,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return PortadaWidgetCardTag(
      background: background,
      padding: _padding,
      child: Text(
        tag,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

class _CategoriaPortadaWidgetCardTag extends PortadaWidgetCardTag {
  final String categoria;
  const _CategoriaPortadaWidgetCardTag({
    required this.categoria,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return PortadaWidgetCardTag.text(
      background: const Color.fromRGBO(187, 247, 208, 1),
      tag: categoria.toUpperCase(),
    );
  }
}

class _EsNuevoPortadaWidgetCardTag extends PortadaWidgetCardTag {
  const _EsNuevoPortadaWidgetCardTag({super.key}) : super._();
  @override
  Widget build(BuildContext context) {
    return const PortadaWidgetCardTag.text(
      background: Color.fromRGBO(199, 210, 254, 1),
      tag: "Nuevo",
    );
  }
}

class _PortadaWidgetCardIconTag extends PortadaWidgetCardTag {
  static EdgeInsets padding = const EdgeInsets.all(2);

  final Color? background;
  final Widget child;

  const _PortadaWidgetCardIconTag({
    this.background,
    required this.child,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      child: PortadaWidgetCardTag(
        background: background ?? const Color.fromRGBO(191, 219, 254, 1),
        padding: padding,
        child: Padding(
          padding: padding,
          child: FittedBox(
            child: child,
          ),
        ),
      ),
    );
  }
}

class _PortadaWidgetCardDestacadoIconTag extends PortadaWidgetCardTag {
  const _PortadaWidgetCardDestacadoIconTag({
    super.key,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return const PortadaWidgetCardTag.icon(
      background: Color.fromRGBO(254, 240, 138, 1),
      child: HiloIcon.destacado(
        color: Color.fromRGBO(31, 41, 55, 1),
      ),
    );
  }
}

class _PortadaWidgetCardEncuestaIconTag extends PortadaWidgetCardTag {
  const _PortadaWidgetCardEncuestaIconTag({
    super.key,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return const PortadaWidgetCardTag.icon(
      child: HiloIcon.encuesta(),
    );
  }
}

class _PortadaWidgetCardDadosIconTag extends PortadaWidgetCardTag {
  const _PortadaWidgetCardDadosIconTag({
    super.key,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return const PortadaWidgetCardTag.icon(
      child: HiloIcon.dados(),
    );
  }
}

class _PortadaWidgetCardIdunicoIconTag extends PortadaWidgetCardTag {
  const _PortadaWidgetCardIdunicoIconTag({
    super.key,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return const PortadaWidgetCardTag.icon(
      child: HiloIcon.idUnico(),
    );
  }
}
