import 'dart:collection';
import 'dart:io';

import 'package:blog_app/features/media/presentation/logic/bloc/miniatura_generador/miniatura_generador_bloc.dart';
import 'package:blog_app/src/lib/features/media/presentation/extensions/media_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:video_compress/video_compress.dart';

import '../domain/models/media.dart';
import '../domain/youtube_service.dart';

class Miniatura extends StatelessWidget {
  final Media media;
  const Miniatura({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MiniaturaGeneradorBloc()..add(GenerarMiniatura(media: media)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          height: 80,
          width: 80,
          child: BlocBuilder<MiniaturaGeneradorBloc, MiniaturaGeneradorState>(
            builder: (context, state) {
              if (state is! MiniaturaGenerada) {
                return const Skeletonizer.zone(child: Bone());
              }
              return Image(
                image: (state).miniatura.toProvider(),
                fit: BoxFit.cover,
              );
            },
          ),
        ),
      ),
    );
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

abstract class IEnlaceVerificador {
  final String url;

  const IEnlaceVerificador({required this.url});
  bool get valido;
}

class YoutubeEnlaceVerificador extends IEnlaceVerificador {
  const YoutubeEnlaceVerificador({required super.url});

  @override
  bool get valido => YoutubeService.EsVideoOrShort(url);
}
