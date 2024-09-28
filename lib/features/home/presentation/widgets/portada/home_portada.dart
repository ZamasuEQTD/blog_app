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

import '../../../../../common/widgets/tag/tag.dart';
import '../../../domain/models/home_portada_entry.dart';

class HomePortada extends StatelessWidget {
  static const _gradient = [
    Colors.black45,
    Colors.transparent,
    Colors.transparent,
    Colors.black45
  ];

  static const _stops = [0.0, 0.3, 0.6, 1.0];

  final HomePortadaEntity portada;

  const HomePortada({super.key, required this.portada});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push("/hilo/${portada.id}"),
      onLongPress: () => OpcionesDePortadaBottomSheet.show(context),
      child: ClipRRect(
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
                              _PortadaFeatures(
                                portada: portada,
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

class _PortadaFeatures extends StatelessWidget {
  static const EdgeInsets padding = EdgeInsets.symmetric(horizontal: 10);
  static final HashMap<HomePortadaFeatures, Widget> _features = HashMap.from({
    HomePortadaFeatures.nuevo: PortadaTag(
        padding: padding,
        color: const Color(0xFF0A78FF),
        child: const FittedBox(
          child: Text(
            "Nuevo",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )),
    HomePortadaFeatures.youtube: PortadaTag(
      color: Colors.transparent,
      padding: padding,
      child: const FaIcon(
        FontAwesomeIcons.youtube,
      ),
    ),
    HomePortadaFeatures.sticky: const _StickyPortadaIcon(),
    HomePortadaFeatures.dados: const _StickyPortadaIcon(),
    HomePortadaFeatures.idUnico: const _StickyPortadaIcon()
  });

  final HomePortadaEntity portada;

  const _PortadaFeatures({super.key, required this.portada});

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      PortadaTag(
        padding: padding,
        color: const Color.fromRGBO(18, 146, 75, 1),
        child: FittedBox(
          child: Text(
            portada.categoria,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      ...generar(portada.features)
    ]);
  }

  static List<Widget> generar(List<HomePortadaFeatures> features) {
    List<Widget> widgets = [];
    for (var i = 0; i < features.length; i++) {
      Widget child = _features[features[i]]!;

      if (i != features.length) {
        child = Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          child: child,
        );
        widgets.add(child);
      }
    }

    return widgets;
  }
}

class _StickyPortadaIcon extends StatelessWidget {
  const _StickyPortadaIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PortadaTag(
      padding: const EdgeInsets.all(2),
      color: const Color(0xffFFC300),
      child: const FittedBox(
        child: FaIcon(
          FontAwesomeIcons.thumbtack,
          color: Colors.white,
        ),
      ),
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

class PortadaTag extends Tag {
  PortadaTag({
    super.key,
    required super.child,
    required super.color,
    required super.padding,
  }) : super(borderRadius: BorderRadius.circular(10));
}
