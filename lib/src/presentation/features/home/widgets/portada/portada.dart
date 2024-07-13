
import 'package:blog_app/src/domain/features/home/models/portada.dart';
import 'package:blog_app/src/presentation/common/widgets/effects/blur/blurear_widget.dart';
import 'package:blog_app/src/presentation/common/widgets/effects/gradient/gradient_effect.dart';
import 'package:blog_app/src/presentation/common/widgets/text/titulo_global.dart';
import 'package:blog_app/src/presentation/features/media/extensions/media_extensions.dart';
import 'package:blog_app/src/presentation/features/media/widgets/image/image_overlapped.dart';
import 'package:flutter/material.dart';

import 'features/banderas.dart';
import 'features/tags.dart';

class PortadaDeHiloHome extends StatelessWidget {
  final PortadaHome portada;

  const PortadaDeHiloHome({super.key, required this.portada});

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
              child: Blurear(blurear: portada.imagen.esSpoiler, child: PortadaDeHiloHomeBody(portada: portada))
          ),
        )
      );
  }
}


class PortadaDeHiloHomeBody extends StatelessWidget {
  final PortadaHome portada;

  const PortadaDeHiloHomeBody({
    super.key, 
    required this.portada
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GradientEffectWidget(
          colors: const [
            Colors.black45,
            Colors.transparent,
            Colors.transparent,
            Colors.black45
          ],
          stops: const [0.0, 0.3, 0.6, 1.0],
        ),
        PortadaDeHiloHomeInformacion(portada: portada),
      ],
    );
  }
}


class PortadaDeHiloHomeInformacion extends StatelessWidget {
  final PortadaHome portada;
  const PortadaDeHiloHomeInformacion({
    super.key, 
    required this.portada
  });

  @override
  Widget build(BuildContext context) {
     return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PortadaDeHiloHomeFeatures(
            portada: portada,
          ),
          TituloGlobal(
            txt: portada.titulo,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            customStyle: const TextStyle(
              color: Colors.white
            ),
          )
        ],
      ),
    );
  }
}

class PortadaDeHiloHomeFeatures extends StatelessWidget {
  final PortadaHome portada;
  const PortadaDeHiloHomeFeatures({
    super.key, 
    required this.portada
  });
  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          TagsDePortadaHome(portada: portada),
          BanderasDePortadaHome(portada: portada)
        ],
    );
  }
}



