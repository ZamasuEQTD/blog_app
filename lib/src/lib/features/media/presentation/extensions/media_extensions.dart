import 'dart:io';

import 'package:flutter/material.dart';

import '../../domain/models/media.dart';
import '../reproductor_de_video/providers/video_provider.dart';

extension ImagenExtensions on Imagen {
  ImageProvider toProvider() {
    switch (provider) {
      case NetworkProvider provider:
        return NetworkImage(provider.path);
      case FileProvider provider:
        return FileImage(File(provider.path), scale: 1);
      default:
        throw Exception("No se puede convertir a [ImageProvider]");
    }
  }
}

extension VideoExtensions on Video {
  VideoProvider toProvider() {
    switch (provider) {
      case NetworkProvider provider:
        return NetworkVideoProvider(provider.path);
      case FileProvider provider:
        return FileVideoProvider(File(provider.path));
      default:
        throw Exception("No se puede convertir a [VideoProvider]");
    }
  }
}
