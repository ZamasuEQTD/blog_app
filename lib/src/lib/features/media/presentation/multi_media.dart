import 'package:blog_app/src/lib/features/media/presentation/extensions/media_extensions.dart';
import 'package:flutter/material.dart';

import '../domain/models/media.dart';
import 'reproductor_de_video/reproductor_de_video.dart';

abstract class Dimensionable extends StatelessWidget {
  const Dimensionable._({super.key});

  const factory Dimensionable({
    Key? key,
    required Widget child,
  }) = _Dimensionable;

  const factory Dimensionable.video({
    Key? key,
    required Video video,
  }) = _Video;

  const factory Dimensionable.imagen({
    Key? key,
    required Imagen imagen,
  }) = _Imagen;
}

class _Dimensionable extends Dimensionable {
  final Widget child;

  const _Dimensionable({super.key, required this.child}) : super._();
  @override
  Widget build(BuildContext context) {
    DimensionableScope? config = DimensionableScope.of(context);

    Widget child = this.child;

    if (config != null) {
      if (config.constraints != null) {
        child = ConstrainedBox(
          constraints: config.constraints!,
          child: child,
        );
      }

      if (config.builder != null) {
        child = config.builder!(context, child);
      }

      if (config.borderRadius != null) {
        child = ClipRRect(
          borderRadius: config.borderRadius!,
          child: child,
        );
      }
    }
    return child;
  }
}

class _Video extends Dimensionable {
  final Video video;
  const _Video({super.key, required this.video}) : super._();

  Widget get reproductor => ReproductorDeVideo.provider(
        provider: video.toProvider(),
      );

  @override
  Widget build(BuildContext context) {
    return Dimensionable(
      child: reproductor,
    );
  }
}

class _Imagen extends Dimensionable {
  final Imagen imagen;
  const _Imagen({
    super.key,
    required this.imagen,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return Dimensionable(
      child: Image(
        image: imagen.toProvider(),
      ),
    );
  }
}

class DimensionableScope extends InheritedWidget {
  final Widget Function(BuildContext context, Widget dimensionable)? builder;
  final BoxConstraints? constraints;
  final BorderRadius? borderRadius;
  const DimensionableScope({
    super.key,
    this.constraints,
    this.borderRadius,
    this.builder,
    required super.child,
  });

  static DimensionableScope? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<DimensionableScope>();

  @override
  bool updateShouldNotify(covariant DimensionableScope oldWidget) {
    return constraints != oldWidget.constraints ||
        borderRadius != oldWidget.borderRadius ||
        builder != oldWidget.builder;
  }
}

class MultiMedia extends StatelessWidget {
  final Media media;
  const MultiMedia({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    switch (media) {
      case Video video:
        return Dimensionable.video(video: video);
      case Imagen imagen:
        return Dimensionable.imagen(imagen: imagen);
    }
    throw Exception("Media no soportada");
  }
}

extension MediaExtension on Media {
  Widget get widget => toWidget(this);

  static Widget toWidget(Media media) {
    switch (media) {
      case Video video:
        return Dimensionable.video(video: video);
      case Imagen imagen:
        return Dimensionable.imagen(imagen: imagen);
    }
    throw Exception("Media no soportada");
  }
}
