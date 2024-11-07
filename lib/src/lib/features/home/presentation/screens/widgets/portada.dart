import 'dart:collection';
import 'dart:math';

import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:blog_app/src/lib/features/media/presentation/extensions/media_extensions.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../app/presentation/widgets/effects/blur/blur_effect.dart';
import '../../../../app/presentation/widgets/effects/gradient/gradient_effect.dart';
import '../../../../app/presentation/widgets/image_overlapped.dart';
import '../../../../app/presentation/widgets/tag.dart';
import '../../../../hilo/presentation/widgets/iconos.dart';

abstract class Portada extends StatelessWidget {
  const Portada._({super.key});

  const factory Portada({
    Key? key,
    required Widget child,
  }) = _Portada;

  const factory Portada.bone() = _PortadaBone;

  const factory Portada.portada({
    Key? key,
    required HomePortada portada,
  }) = _PortadaCargada;
}

class _Portada extends Portada {
  final Widget child;

  const _Portada({super.key, required this.child}) : super._();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: child,
    );
  }
}

class _PortadaBone extends Portada {
  static final _random = Random();

  const _PortadaBone({super.key}) : super._();

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

class _PortadaCargada extends Portada {
  static const _gradient = [
    Colors.black45,
    Colors.transparent,
    Colors.transparent,
    Colors.black45,
  ];

  static const _stops = [0.0, 0.3, 0.6, 1.0];

  final HomePortada portada;

  const _PortadaCargada({
    super.key,
    required this.portada,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return Portada(
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

  final HomePortada portada;

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

  static List<Widget> generar(HomePortada portada) {
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

abstract class PortadaCardTag extends StatelessWidget {
  const PortadaCardTag._({super.key});

  const factory PortadaCardTag({
    Key? key,
    required Color background,
    required EdgeInsets padding,
    required Widget child,
  }) = _PortadaCardTag;

  const factory PortadaCardTag.text({
    required Color background,
    required String tag,
  }) = _TextPortadaCardTag;

  const factory PortadaCardTag.categoria({required String categoria}) =
      _CategoriaPortadaCardTag;

  const factory PortadaCardTag.nuevo() = _EsNuevoPortadaCardTag;

  const factory PortadaCardTag.icon({
    Color? background,
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

  final Color background;
  final EdgeInsets padding;
  final Widget child;
  const _PortadaCardTag({
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
      child: Text(
        tag,
        style: const TextStyle(
          fontWeight: FontWeight.w900,
        ),
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
    return PortadaCardTag.text(
      background: const Color.fromRGBO(187, 247, 208, 1),
      tag: categoria,
    );
  }
}

class _EsNuevoPortadaCardTag extends PortadaCardTag {
  const _EsNuevoPortadaCardTag({super.key}) : super._();
  @override
  Widget build(BuildContext context) {
    return const PortadaCardTag.text(
      background: Color.fromRGBO(199, 210, 254, 1),
      tag: "Nuevo",
    );
  }
}

class _PortadaCardIconTag extends PortadaCardTag {
  static EdgeInsets padding = const EdgeInsets.all(2);

  final Color? background;
  final Widget child;

  const _PortadaCardIconTag({
    this.background,
    required this.child,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      child: PortadaCardTag(
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

class _PortadaCardDestacadoIconTag extends PortadaCardTag {
  const _PortadaCardDestacadoIconTag({
    super.key,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return const PortadaCardTag.icon(
      background: Color.fromRGBO(254, 240, 138, 1),
      child: HiloIcon.destacado(
        color: Color.fromRGBO(31, 41, 55, 1),
      ),
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
      child: HiloIcon.encuesta(),
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
      child: HiloIcon.dados(),
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
      child: HiloIcon.idUnico(),
    );
  }
}
