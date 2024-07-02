import 'package:blog_app/src/presentation/features/media/widgets/media_box/media_box.dart';
import 'package:flutter/material.dart';

import '../../../../../../../domain/features/media/models/media.dart';
import '../../../../../../../domain/shared/models/spoileable.dart';

class ComentarioMedia extends StatelessWidget {
  final Spoileable<Media>? media;
  const ComentarioMedia({super.key, this.media});

  @override
  Widget build(BuildContext context) {
    if(media != null) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: BlurearbleMultiMediaBox(media: media!),
      );
    }
    return const SizedBox();
  }
}

class BlurearbleMultiMediaBox extends StatelessWidget {
  final Spoileable<Media> media;
  const BlurearbleMultiMediaBox({
    super.key,
    required this.media,
  });

  @override
  Widget build(BuildContext context) {
    return MediaBox(media: media.spoileable, options: const MediaBoxOptions(
      borderRadius: 10,
      constraints: BoxConstraints(
        maxHeight: 300,
        maxWidth: double.infinity
      )
    ));
  }
}