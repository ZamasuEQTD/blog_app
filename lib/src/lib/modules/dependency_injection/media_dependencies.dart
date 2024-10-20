import 'package:get_it/get_it.dart';

import '../../features/media/data/file_picker_gallery_service.dart';
import '../../features/media/data/video_compress_miniatura_video_generador.dart';
import '../../features/media/domain/igallery_service.dart';
import '../../features/media/domain/iminiatura_video_service.dart';
import '../../features/media/presentation/logic/blocs/miniatura_generador/miniatura_generador_bloc.dart';

extension MediaDependencies on GetIt {
  GetIt addMedia() {
    registerLazySingleton<IGalleryService>(() => FilePickerGalleryService());
    registerLazySingleton<IMiniaturaVideoGenerador>(
      () => VideoCompressMiniaturaGenerador(),
    );

    registerLazySingleton<IMiniaturaStrategy>(
      () => VideoMiniaturaStrategy(get()),
      instanceName: "video",
    );
    registerLazySingleton<IMiniaturaStrategy>(
      () => YoutubeMiniaturaStrategy(),
      instanceName: "youtube",
    );
    registerLazySingleton<IMiniaturaStrategy>(
      () => ImagenMiniaturaStrategy(),
      instanceName: "imagen",
    );

    return this;
  }
}
