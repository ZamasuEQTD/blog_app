import '../../../domain/models/media.dart';
import 'package:flutter/material.dart';
import '../../logic/extensions/media_extensions.dart';
import '../reproductor_de_video/reproductor_de_video.dart';

class DimensionableMedia extends StatelessWidget {
  final Media media;
  final BoxConstraints? constraints;
  const DimensionableMedia({super.key, required this.media, this.constraints})
      : assert(media is Video || media is Imagen);

  @override
  Widget build(BuildContext context) {
    switch (media) {
      case Imagen media:
        return Image(image: media.toProvider());
      case Video media:
        return ReproductorDeVideoWidget.fromProvider(
            previsualizacion: media.previsualizacion != null
                ? const NetworkImage("https://i.redd.it/eopud74baswa1.png")
                : null,
            provider: media.toProvider());
      default:
        throw Exception("Tipo de media no soportado!!!");
    }
  }
}

class MultiMediaDisplay extends StatelessWidget {
  final Media media;
  final Widget Function(DimensionableMedia child)? dimensionableBuilder;
  const MultiMediaDisplay(
      {super.key, required this.media, this.dimensionableBuilder});

  @override
  Widget build(BuildContext context) {
    if (media is Video || media is Imagen) {
      return dimensionableBuilder != null
          ? dimensionableBuilder!(DimensionableMedia(media: media))
          : DimensionableMedia(media: media);
    }
    throw Exception("Tipo de media no soportado!!!");
  }
}

class MediaBox extends StatelessWidget {
  final Media media;
  final MediaBoxOptions options;
  const MediaBox({
    super.key,
    required this.media,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: options.constraints, child: _getMedia(context));
  }

  Widget _getMedia(BuildContext context) {
    return options.builder != null
        ? options.builder!(
            context,
            MediaManager(
              media: media,
            ))
        : MediaManager(
            media: media,
          );
  }
}

class MediaBoxOptions {
  final BoxConstraints? constraints;
  final Widget Function(BuildContext context, Widget child)? builder;

  const MediaBoxOptions({this.constraints, this.builder});
}

class MediaManager extends StatelessWidget {
  final Media media;

  const MediaManager({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    switch (media) {
      case Imagen media:
        return Image(image: media.toProvider());
      case Video media:
        return ReproductorDeVideoWidget.fromProvider(
            previsualizacion: media.previsualizacion != null
                ? NetworkImage(media.previsualizacion!)
                : null,
            provider: media.toProvider());
      default:
        throw Exception("Tipo de media no soportado!!!");
    }
  }
}
