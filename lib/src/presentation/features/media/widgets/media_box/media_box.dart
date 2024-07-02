import 'package:flutter/material.dart';
import '../../../../../domain/features/media/models/media.dart';
import '../../extensions/media_extensions.dart';
import '../reproductor_de_video/reproductor_de_video.dart';
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(options.borderRadius),
      child: Container(
        constraints: options.constraints,
        child: _getMedia(context)
      ),
    );
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
  final double borderRadius;
  final BoxConstraints? constraints;
  final Widget Function(BuildContext context, Widget child)? builder;

  const MediaBoxOptions({
    this.borderRadius = 0,
    this.constraints,
    this.builder
  });
}


class MediaManager extends StatelessWidget {
  final Media media;
  const MediaManager({super.key, required this.media}):assert(media is! Imagen || media is! Video);

  @override
  Widget build(BuildContext context) {
    if(media is Video) {
      return ReproductorDeVideoWidget.fromVideoMedia(video: media as Video);
    }
    
    if(media is Imagen) {
      return Image(image: (media as Imagen).toProvider());
    }
    throw Exception("Tipo de media no soportado!!!");
  }
}
