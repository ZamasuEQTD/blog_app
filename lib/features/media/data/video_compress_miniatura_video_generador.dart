import 'dart:io';

import 'package:video_compress/video_compress.dart';

import '../domain/abstractions/iminiatura_video_service.dart';
import '../domain/models/media.dart';

class VideoCompressMiniaturaGenerador extends IMiniaturaVideoGenerador {
  @override
  Future<Imagen> generar(String path) async {
    File miniatura = await VideoCompress.getFileThumbnail(
      path,
    );

    return Imagen(provider: FileProvider(path: miniatura.path));
  }
}
