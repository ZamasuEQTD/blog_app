import 'package:blog_app/features/media/domain/abstractions/iminiatura_video_service.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:blog_app/features/media/domain/services/youtube_service.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class MiniaturaController extends GetxController {
  final Media media;
  final IMiniaturaFactory _factory = GetIt.I.get();

  final status = MiniaturaStatus.initial.obs;

  MiniaturaController({required this.media});

  Rx<Imagen?> miniatura = Rx(null);

  Future<void> generar() async {
    status.value = MiniaturaStatus.generando;

    miniatura.value =
        await _factory.create(media).getMiniatura(media.provider.path);

    status.value = MiniaturaStatus.generada;
  }
}

enum MiniaturaStatus {
  initial,
  generando,
  generada,
}

abstract class IMiniaturaFactory {
  IMiniaturaService create(Media media);
}

class GetItMiniaturaFactory implements IMiniaturaFactory {
  @override
  IMiniaturaService create(Media media) {
    switch (media.tipo) {
      case TipoDeMedia.video:
        return GetIt.I.get<VideoMiniaturaService>();
      case TipoDeMedia.imagen:
        return GetIt.I.get<ImagenMiniaturaService>();
      case TipoDeMedia.youtube:
        return GetIt.I.get<YoutubeMiniaturaService>();
    }
    throw Exception("Tipo de media no soportado");
  }
}

abstract class IMiniaturaService {
  Future<Imagen> getMiniatura(String media);
}

class VideoMiniaturaService extends IMiniaturaService {
  final IMiniaturaVideoGenerador _generador;

  VideoMiniaturaService(this._generador);
  @override
  Future<Imagen> getMiniatura(String media) {
    return _generador.generar(media);
  }
}

class YoutubeMiniaturaService extends IMiniaturaService {
  @override
  Future<Imagen> getMiniatura(String media) {
    return Future.value(
      Imagen(
        provider: NetworkProvider(
          path: YoutubeService.miniaturaFromUrl(media)!,
        ),
      ),
    );
  }
}

class ImagenMiniaturaService extends IMiniaturaService {
  @override
  Future<Imagen> getMiniatura(String media) {
    return Future.value(Imagen(provider: FileProvider(path: media)));
  }
}
