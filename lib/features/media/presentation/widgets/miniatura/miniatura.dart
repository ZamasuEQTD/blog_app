import 'dart:collection';

import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:blog_app/features/media/presentation/logic/extension/media_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../domain/services/youtube_service.dart';
import '../../logic/controller/miniatura_controller.dart';

class Miniatura extends StatelessWidget {
  final Media media;
  const Miniatura({super.key, required this.media});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      global: false,
      init: MiniaturaController(media: media)..generar(),
      builder: (controller) => ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox.square(
          dimension: 80,
          child: Obx(() {
            if (controller.status.value != MiniaturaStatus.generada) {
              return const Skeletonizer.zone(child: Bone());
            }
            return Image(
              image: controller.miniatura.value!.toProvider,
              fit: BoxFit.cover,
            );
          }),
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
