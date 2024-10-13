import 'dart:collection';
import 'package:flutter/material.dart';

import 'package:blog_app/common/widgets/effects/blur/blur_effect.dart';
import 'package:blog_app/common/widgets/effects/gradient/gradient_effect.dart';
import 'package:blog_app/common/widgets/media/widgets/image/image_overlapped.dart';
import 'package:blog_app/features/media/presentation/logic/extensions/media_extensions.dart';

import '../../../../../common/widgets/tag/tag.dart';
import '../../../domain/models/home_portada_entry.dart';

const double PORTADA_HEIGHT_TAG = 22;
const EdgeInsets PORTADA_TEXT_PADDING =
    EdgeInsets.symmetric(horizontal: 5, vertical: 2);
const TextStyle TEXT_TAG_STYLE =
    TextStyle(color: Colors.white, fontWeight: FontWeight.w900);

class PortadaCard extends StatelessWidget {
  static const _gradient = [
    Colors.black45,
    Colors.transparent,
    Colors.transparent,
    Colors.black45,
  ];

  static const _stops = [0.0, 0.3, 0.6, 1.0];

  final PortadaEntity portada;

  const PortadaCard({super.key, required this.portada});

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
    HomePortadaFeatures.nuevo: const Tag(
      background: Colors.blue,
      height: PORTADA_HEIGHT_TAG,
      padding: PORTADA_TEXT_PADDING,
      child: FittedBox(
        child: Text(
          "Nuevo",
          style: TEXT_TAG_STYLE,
        ),
      ),
    ),
    HomePortadaFeatures.sticky: const Tag(
      height: PORTADA_HEIGHT_TAG,
      background: Color(0xffffa900),
      padding: EdgeInsets.all(2),
      child: FittedBox(
        child: Icon(
          Icons.key_rounded,
          color: Colors.white,
        ),
      ),
    ),
    HomePortadaFeatures.dados: const Tag(
      background: Color(0xffffa900),
      padding: EdgeInsets.all(2),
      child: FittedBox(
        child: Icon(
          Icons.bar_chart,
          color: Colors.white,
        ),
      ),
    ),
    HomePortadaFeatures.idUnico: const Tag(
      background: Color(0xffffa900),
      padding: EdgeInsets.all(2),
      child: FittedBox(
        child: Icon(
          Icons.casino,
          color: Colors.white,
        ),
      ),
    ),
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
      Tag(
        height: PORTADA_HEIGHT_TAG,
        background: Colors.green,
        padding: PORTADA_TEXT_PADDING,
        child: FittedBox(
          child: Text(
            portada.categoria,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
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
