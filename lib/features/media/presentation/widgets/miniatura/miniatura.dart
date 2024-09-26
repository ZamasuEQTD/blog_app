import 'dart:collection';
import 'dart:io';

import 'package:blog_app/features/media/presentation/logic/bloc/miniatura_generador/miniatura_generador_bloc.dart';
import 'package:blog_app/features/media/presentation/logic/extensions/media_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/models/media.dart';

class Miniatura extends StatelessWidget {
  static const IMiniaturaFactory _factory = MiniaturaFactory();
  final Media media;
  const Miniatura({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(height: 80, width: 80, child: _factory.create(media)));
  }
}

abstract class IMiniaturaFactory {
  const IMiniaturaFactory();

  Widget create(Media media);
}

class MiniaturaFactory extends IMiniaturaFactory {
  const MiniaturaFactory();
  @override
  Widget create(Media media) {
    switch (media) {
      case Video video:
        return VideoMiniatura(video: video);
      case Imagen imagen:
        return Image(image: imagen.toProvider());
      default:
        throw ArgumentError("");
    }
  }
}

class VideoMiniatura extends StatelessWidget {
  final Video video;
  const VideoMiniatura({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    if (video.provider is FileProvider) {
      return BlocProvider(
        create: (context) => MiniaturaGeneradorBloc(video.provider.path),
        child: BlocBuilder<MiniaturaGeneradorBloc, MiniaturaGeneradorState>(
          builder: (context, state) {
            switch (state) {
              case MiniaturaGenerada state:
                return Image.file(File(state.path));
              default:
                return Container();
            }
          },
        ),
      );
    }
    return Image.network(video.previsualizacion!);
  }
}

class MiniaturaGenerador extends StatelessWidget {
  final String path;
  const MiniaturaGenerador({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ImagenMiniatura extends StatelessWidget {
  final Imagen imagen;
  const ImagenMiniatura({super.key, required this.imagen});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MiniaturaDatosOverlay extends StatelessWidget {
  const MiniaturaDatosOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
        padding: EdgeInsets.all(5),
        child: Align(
          alignment: Alignment.topRight,
        ));
  }
}

class UrlsDomains {
  static final HashMap<String, String> _providers =
      HashMap.from({"www.youtube.com": "YTB"});

  static String providerFromUrl(String url) {
    final Uri uri = Uri.parse(url);

    if (_providers[uri.host] == null) {
      throw ArgumentError("Provider no registrado");
    }

    return _providers[uri.host]!;
  }
}
