import 'package:flutter/material.dart';

import '../../../../domain/features/media/entities/media.dart';
import '../classes/video_providers.dart';

extension ImagenExtensions on Imagen {
  ImageProvider toProvider (){
    switch (datos.source) {
      case NetworkMediaProvider provider:
        return NetworkImage(provider.url);
      case FileMediaProvider provider:
        return FileImage(provider.file);
      default:
        throw Exception("No se puede convertir a [ImageProvider]");
    }
  }
}
extension VideoExtensions on Video {
  VideoProvider toProvider(){
    switch (datos.source) {
      case NetworkMediaProvider provider:
        return NetworkVideoProvider(provider.url);
      case FileMediaProvider provider:
        return FileVideoProvider(provider.file);
      default:
        throw Exception("No se puede convertir a [VideoProvider]");
    }
  }
}