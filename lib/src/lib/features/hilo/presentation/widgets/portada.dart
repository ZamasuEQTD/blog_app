import 'dart:collection';
import 'dart:math';

import 'package:blog_app/src/lib/features/app/presentation/widgets/effects/blur/blur_effect.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/effects/gradient/gradient_effect.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/image_overlapped.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/tag.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/screens/hilo/widgets/iconos.dart';
import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:blog_app/src/lib/features/media/presentation/extensions/media_extensions.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

abstract class PortadaView extends StatelessWidget {
  const PortadaView._({super.key});

  const factory PortadaView({
    Key? key,
    required Widget child,
  }) = _PortadaView;

  const factory PortadaView.bone() = _PortadaViewBone;

  const factory PortadaView.portada({
    Key? key,
    required Portada portada,
  }) = _PortadaViewCargada;
}

class _PortadaView extends PortadaView {
  final Widget child;

  const _PortadaView({super.key, required this.child}) : super._();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: child,
    );
  }
}

class _PortadaViewBone extends PortadaView {
  static final _random = Random();

  const _PortadaViewBone({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: ColoredBox(
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
      ),
    );
  }
}

class _PortadaViewCargada extends PortadaView {
  static const _gradient = [
    Colors.black45,
    Colors.transparent,
    Colors.transparent,
    Colors.black45,
  ];

  static const _stops = [0.0, 0.3, 0.6, 1.0];

  final Portada portada;

  const _PortadaViewCargada({
    super.key,
    required this.portada,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return PortadaView(
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
                        style: const TituloDePortadaViewTextStyle(),
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
  static final HashMap<PortadaFeatures, Widget> _features = HashMap.from({
    PortadaFeatures.nuevo: const PortadaViewCardTag.nuevo(),
    PortadaFeatures.sticky: const PortadaViewCardTag.destacado(),
    PortadaFeatures.dados: const PortadaViewCardTag.dados(),
    PortadaFeatures.idUnico: const PortadaViewCardTag.idUnico(),
  });

  final Portada portada;

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

  static List<Widget> generar(Portada portadaView) {
    List<Widget> tags = [
      PortadaViewCardTag.categoria(categoria: portadaView.categoria),
    ];

    for (var i = 0; i < portadaView.features.length; i++) {
      Widget child = _features[portadaView.features[i]]!;

      tags.add(child);
    }

    return tags;
  }
}

class TituloDePortadaViewTextStyle extends TextStyle {
  const TituloDePortadaViewTextStyle()
      : super(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          overflow: TextOverflow.ellipsis,
          color: Colors.white,
        );
}

abstract class PortadaViewCardTag extends StatelessWidget {
  const PortadaViewCardTag._({super.key});

  const factory PortadaViewCardTag({
    Key? key,
    required Color background,
    required EdgeInsets padding,
    required Widget child,
  }) = _PortadaViewCardTag;

  const factory PortadaViewCardTag.text({
    required Color background,
    required String tag,
  }) = _TextPortadaViewCardTag;

  const factory PortadaViewCardTag.categoria({required String categoria}) =
      _CategoriaPortadaViewCardTag;

  const factory PortadaViewCardTag.nuevo() = _EsNuevoPortadaViewCardTag;

  const factory PortadaViewCardTag.icon({
    Color? background,
    required Widget child,
  }) = _PortadaViewCardIconTag;

  const factory PortadaViewCardTag.destacado({Key? key}) =
      _PortadaViewCardDestacadoIconTag;

  const factory PortadaViewCardTag.encuesta({Key? key}) =
      _PortadaViewCardEncuestaIconTag;

  const factory PortadaViewCardTag.dados({Key? key}) =
      _PortadaViewCardDadosIconTag;

  const factory PortadaViewCardTag.idUnico({Key? key}) =
      _PortadaViewCardIdunicoIconTag;
}

class _PortadaViewCardTag extends PortadaViewCardTag {
  static const double height = 22;

  final Color background;
  final EdgeInsets padding;
  final Widget child;
  const _PortadaViewCardTag({
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

class _TextPortadaViewCardTag extends PortadaViewCardTag {
  static const EdgeInsets _padding =
      EdgeInsets.symmetric(horizontal: 5, vertical: 2);
  final Color background;
  final String tag;

  const _TextPortadaViewCardTag({
    required this.background,
    required this.tag,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return PortadaViewCardTag(
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

class _CategoriaPortadaViewCardTag extends PortadaViewCardTag {
  final String categoria;
  const _CategoriaPortadaViewCardTag({
    required this.categoria,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return PortadaViewCardTag.text(
      background: const Color.fromRGBO(187, 247, 208, 1),
      tag: categoria,
    );
  }
}

class _EsNuevoPortadaViewCardTag extends PortadaViewCardTag {
  const _EsNuevoPortadaViewCardTag({super.key}) : super._();
  @override
  Widget build(BuildContext context) {
    return const PortadaViewCardTag.text(
      background: Color.fromRGBO(199, 210, 254, 1),
      tag: "Nuevo",
    );
  }
}

class _PortadaViewCardIconTag extends PortadaViewCardTag {
  static EdgeInsets padding = const EdgeInsets.all(2);

  final Color? background;
  final Widget child;

  const _PortadaViewCardIconTag({
    this.background,
    required this.child,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 22,
      child: PortadaViewCardTag(
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

class _PortadaViewCardDestacadoIconTag extends PortadaViewCardTag {
  const _PortadaViewCardDestacadoIconTag({
    super.key,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return const PortadaViewCardTag.icon(
      background: Color.fromRGBO(254, 240, 138, 1),
      child: HiloIcon.destacado(
        color: Color.fromRGBO(31, 41, 55, 1),
      ),
    );
  }
}

class _PortadaViewCardEncuestaIconTag extends PortadaViewCardTag {
  const _PortadaViewCardEncuestaIconTag({
    super.key,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return const PortadaViewCardTag.icon(
      child: HiloIcon.encuesta(),
    );
  }
}

class _PortadaViewCardDadosIconTag extends PortadaViewCardTag {
  const _PortadaViewCardDadosIconTag({
    super.key,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return const PortadaViewCardTag.icon(
      child: HiloIcon.dados(),
    );
  }
}

class _PortadaViewCardIdunicoIconTag extends PortadaViewCardTag {
  const _PortadaViewCardIdunicoIconTag({
    super.key,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return const PortadaViewCardTag.icon(
      child: HiloIcon.idUnico(),
    );
  }
}
