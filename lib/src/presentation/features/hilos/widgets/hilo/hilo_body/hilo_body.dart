import 'package:blog_app/src/domain/features/hilos/models/hilo.dart';
import 'package:blog_app/src/domain/features/media/models/media.dart';
import 'package:blog_app/src/domain/shared/models/spoileable.dart';
import 'package:blog_app/src/presentation/features/hilos/widgets/hilo/hilo_body/features/features_icons.dart';
import 'package:flutter/material.dart';

class HiloBody extends StatelessWidget {
  final Hilo hilo;
  const HiloBody({
    super.key, 
    required this.hilo
  });

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
              CategoriaDeHilo(),
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
  const AccionesDeHilo({
    super.key, 
    required this.hilo
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class MediaDeHilo extends StatelessWidget {
  final Spoileable<Media> media;
  const MediaDeHilo({
    super.key, 
    required this.media
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class InformacionDeHilo extends StatelessWidget {
  final Hilo hilo;

  const InformacionDeHilo({super.key, required this.hilo});

  @override
  Widget build(BuildContext context) {
    return Column(
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
  const Titulo({
    super.key, 
    required this.titulo
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class Descripcion extends StatelessWidget {
  final String descripcion;
  const Descripcion({super.key, required this.descripcion});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}