import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:blog_app/features/media/presentation/logic/extension/media_extension.dart';
import 'package:blog_app/features/media/presentation/widgets/video/reproductor.dart';
import 'package:blog_app/features/media/presentation/widgets/youtube/youtube_reproductor.dart';
import 'package:flutter/material.dart';

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

  const factory Dimensionable.youtube({
    Key? key,
    required Youtube video,
  }) = _Youtube;
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

  @override
  Widget build(BuildContext context) {
    return Dimensionable(
      child: ReproductorDeVideo.provider(
        provider: video.toProvider,
        previsualizacion: video.previsualizacion != null
            ? NetworkImage(video.previsualizacion!)
            : null,
      ),
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
        image: imagen.toProvider,
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

class _Youtube extends Dimensionable {
  final Youtube video;
  const _Youtube({super.key, required this.video}) : super._();

  @override
  Widget build(BuildContext context) {
    return YoutubeReproductor(video: video);
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
      case Youtube video:
        return Dimensionable.youtube(video: video);
    }
    throw Exception("Media no soportada");
  }
}
