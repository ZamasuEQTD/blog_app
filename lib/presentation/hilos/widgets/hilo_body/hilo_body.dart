import 'package:blog_app/common/widgets/effects/blur/blurear_widget.dart';
import 'package:blog_app/domain/features/common/entities/spoileable.dart';
import 'package:blog_app/domain/features/hilo/entities/hilo.dart';
import 'package:blog_app/domain/features/media/entities/media.dart';
import 'package:blog_app/presentation/media/widgets/media_box/media_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'features/features_icons.dart';

class HiloBody extends StatelessWidget {
  final Hilo hilo;
  const HiloBody({super.key, required this.hilo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(7),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FeaturesIconsDeHilo(banderas: hilo.banderas),
              const CategoriaDeHilo(),
              AccionesDeHilo(hilo: hilo),
              MediaDeHilo(media: hilo.archivo),
              InformacionDeHilo(hilo: hilo)
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriaDeHilo extends StatelessWidget {
  const CategoriaDeHilo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class AccionesDeHilo extends StatelessWidget {
  final Hilo hilo;
  const AccionesDeHilo({super.key, required this.hilo});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MediaDeHilo extends StatelessWidget {
  final Spoileable<Media> media;
  const MediaDeHilo({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return MediaSpoileable(
        child: MediaBox(
            media: media.spoileable,
            options: const MediaBoxOptions(
                constraints: BoxConstraints(
                    maxHeight: 350, maxWidth: double.infinity))));
  }
}

class MediaSpoileable extends StatelessWidget {
  final Widget child;
  const MediaSpoileable({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: BlurBuilder(
          builder: (context, child, controller) {
            return Stack(
              children: [
                child,
                controller.blurear
                    ? Positioned.fill(
                        child: Center(
                        child: OutlinedButton(
                            onPressed: controller.switchBlur,
                            style: const ButtonStyle(
                                side: WidgetStatePropertyAll(BorderSide(
                                    width: 0.5, color: Colors.white)),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)))),
                                padding: WidgetStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 30))),
                            child: const Text(
                              "Ver contenido",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )),
                      ))
                    : const SizedBox()
              ],
            );
          },
          child: child),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Stack(
        children: [
          BlurearWidget(child: child),
          Positioned.fill(
              child: Center(
            child: OutlinedButton(
                onPressed: () {},
                style: const ButtonStyle(
                    side: WidgetStatePropertyAll(
                        BorderSide(width: 1, color: Colors.white)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)))),
                    padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(vertical: 20, horizontal: 30))),
                child: const Text(
                  "Ver contenido",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
          ))
        ],
      ),
    );
  }
}

class InformacionDeHilo extends StatelessWidget {
  final Hilo hilo;

  const InformacionDeHilo({super.key, required this.hilo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Titulo(titulo: hilo.titulo),
        Descripcion(descripcion: hilo.descripcion)
      ],
    );
  }
}

class Titulo extends StatelessWidget {
  final String titulo;
  const Titulo({super.key, required this.titulo});

  @override
  Widget build(BuildContext context) {
    return Text(
      titulo,
      style: const TextStyle(fontSize: 29, fontWeight: FontWeight.w900),
    );
  }
}

class Descripcion extends StatelessWidget {
  final String descripcion;
  const Descripcion({super.key, required this.descripcion});

  @override
  Widget build(BuildContext context) {
    return Text(
      descripcion,
      style: const TextStyle(fontSize: 18),
    );
  }
}
