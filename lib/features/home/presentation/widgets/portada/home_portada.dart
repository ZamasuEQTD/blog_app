import 'dart:collection';

import 'package:blog_app/common/widgets/effects/blur/blur_effect.dart';
import 'package:blog_app/common/widgets/effects/blur/blurear_widget.dart';
import 'package:blog_app/common/widgets/effects/gradient/gradient_effect.dart';
import 'package:blog_app/common/widgets/media/widgets/image/image_overlapped.dart';
import 'package:blog_app/features/home/presentation/widgets/portada/bottom_sheet/opciones_bottom_sheet.dart';
import 'package:blog_app/features/media/presentation/logic/extensions/media_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/models/home_portada_entry.dart';

class HomePortada extends StatelessWidget {
  static const _gradient = [
    Colors.black45,
    Colors.transparent,
    Colors.transparent,
    Colors.black45
  ];

  static const _stops = [0.0, 0.3, 0.6, 1.0];

  final HomePortadaListEntry portada;

  const HomePortada({super.key, required this.portada});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go("location"),
      onLongPress: () => OpcionesDePortadaBottomSheet.show(context),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
              height: 200,
              width: 200,
              child: ImageOverlapped.provider(
                  provider: portada.imagen.spoileable.toProvider(),
                  boxFit: BoxFit.cover,
                  child: Stack(
                    children: [
                      portada.imagen.esSpoiler
                          ? const BlurEffect()
                          : const SizedBox(),
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
                              Row(
                                children: [
                                  _Features(portada: portada),
                                  _Banderas(portada: portada)
                                ],
                              ),
                              Text(portada.titulo,
                                  maxLines: 2,
                                  style: const TituloDePortadaTextStyle())
                            ],
                          ))
                    ],
                  )))),
    );
  }
}

class _Banderas extends StatelessWidget {
  static final HashMap<HomePortadaBanderas, Widget> _banderas = HashMap.from({
    HomePortadaBanderas.idUnico:
        const FaIcon(FontAwesomeIcons.person, color: Colors.white),
    HomePortadaBanderas.dados:
        const FaIcon(FontAwesomeIcons.diceThree, color: Colors.white)
  });

  final HomePortadaListEntry portada;

  const _Banderas({
    super.key,
    required this.portada,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: portada.banderas.map((e) => _banderas[e]!).toList(),
    );
  }
}

class _Features extends StatelessWidget {
  static final HashMap<HomePortadaFeatures, Widget> _features = HashMap.from({
    HomePortadaFeatures.nuevo: const _HomePortadaTag(
        color: Color(0xFF0A78FF),
        child: FittedBox(
          child: Text(
            "Nuevo",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )),
    HomePortadaFeatures.youtube: const Padding(
      padding: EdgeInsets.all(5),
      child: FaIcon(FontAwesomeIcons.youtube, color: Colors.white),
    ),
    HomePortadaFeatures.sticky: const _StickyPortadaIcon()
  });

  const _Features({
    super.key,
    required this.portada,
  });

  final HomePortadaListEntry portada;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Row(children: [
        _HomePortadaTag(
          color: const Color.fromRGBO(18, 146, 75, 1),
          child: FittedBox(
            child: Text(
              portada.categoria,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        ...portada.features.map((e) => _features[e]!).map((w) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.5),
              child: w,
            ))
      ]),
    );
  }
}

class _StickyPortadaIcon extends StatelessWidget {
  const _StickyPortadaIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: const ColoredBox(
          color: Color(0xffFFC300),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: FaIcon(
              FontAwesomeIcons.thumbtack,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class Tag extends StatelessWidget {
  final Widget child;
  final Color color;
  final BorderRadiusGeometry borderRadius;

  const Tag(
      {super.key,
      required this.child,
      required this.color,
      required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: ColoredBox(
        color: color,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          child: child,
        ),
      ),
    );
  }
}

class _HomePortadaTag extends StatelessWidget {
  final Color color;
  final Widget child;
  const _HomePortadaTag({super.key, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Tag(
      color: color,
      borderRadius: BorderRadius.circular(3),
      child: child,
    );
  }
}

class TituloDePortadaTextStyle extends TextStyle {
  const TituloDePortadaTextStyle()
      : super(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            overflow: TextOverflow.ellipsis,
            color: Colors.white);
}
