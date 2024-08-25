import 'dart:collection';

import 'package:blog_app/common/widgets/effects/blur/blur_effect.dart';
import 'package:blog_app/common/widgets/effects/blur/blurear_widget.dart';
import 'package:blog_app/common/widgets/effects/gradient/gradient_effect.dart';
import 'package:blog_app/common/widgets/media/widgets/image/image_overlapped.dart';
import 'package:blog_app/features/media/presentation/logic/extensions/media_extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

import '../../../domain/models/home_portada_entry.dart';

class HomePortada extends StatelessWidget {
  static final HashMap<HomePortadaBanderas, Widget> _banderas = HashMap();

  static final HashMap<HomePortadaFeatures, Widget> _features =
      HashMap.from({});

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
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
            height: 200,
            width: 200,
            child: ImageOverlapped.provider(
                provider: portada.imagen.spoileable.toProvider(),
                boxFit: BoxFit.cover,
                child: Stack(
                  children: [
                    const BlurEffect(),
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
                                Row(
                                  children: [
                                    _CategoriaTag(portada: portada),
                                    ...portada.features
                                        .map((e) => _features[e]!)
                                  ],
                                ),
                                Row(
                                  children: portada.banderas
                                      .map((e) => _banderas[e]!)
                                      .toList(),
                                )
                              ],
                            ),
                            Text(portada.titulo,
                                maxLines: 2,
                                style: const TituloDePortadaTextStyle())
                          ],
                        ))
                  ],
                ))));
  }
}

class _CategoriaTag extends StatelessWidget {
  const _CategoriaTag({
    super.key,
    required this.portada,
  });

  final HomePortadaListEntry portada;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), color: Colors.green),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        child: FittedBox(
          child: Text(
            portada.categoria,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
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
