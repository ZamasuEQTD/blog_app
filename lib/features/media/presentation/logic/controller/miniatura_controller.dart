import 'package:blog_app/features/app/domain/abstractions/istrategy_context.dart';
import 'package:blog_app/features/media/domain/abstractions/iminiatura_video_service.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:blog_app/features/media/domain/services/youtube_service.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

class MiniaturaController extends GetxController {
  final Media media;
  final IStrategyContext _strategyContext = GetIt.I.get();

  final status = MiniaturaStatus.initial.obs;

  MiniaturaController({required this.media});

  Rx<Imagen?> miniatura = Rx(null);

  Future<void> generar() async {
    status.value = MiniaturaStatus.generando;

    miniatura.value =
        await _strategyContext.execute<String, Imagen, IMiniaturaStrategy>(
      media.tipo.value,
      media.provider.path,
    );

    status.value = MiniaturaStatus.generada;
  }
}

enum MiniaturaStatus {
  initial,
  generando,
  generada,
}

abstract class IMiniaturaStrategy extends IStrategy<String, Imagen> {}

class VideoMiniaturaStrategy extends IMiniaturaStrategy {
  final IMiniaturaVideoGenerador _generador;

  VideoMiniaturaStrategy(this._generador);
  @override
  Future<Imagen> execute(String input) {
    return _generador.generar(input);
  }
}

class ImagenMiniaturaStrategy extends IMiniaturaStrategy {
  @override
  Future<Imagen> execute(String input) {
    return Future.value(Imagen(provider: FileProvider(path: input)));
  }
}

class YoutubeMiniaturaStrategy extends IMiniaturaStrategy {
  @override
  Future<Imagen> execute(String input) {
    return Future.value(
      Imagen(
        provider:
            NetworkProvider(path: YoutubeService.miniaturaFromUrl(input)!),
      ),
    );
  }
}
