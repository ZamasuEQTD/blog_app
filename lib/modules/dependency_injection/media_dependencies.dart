import 'package:blog_app/features/media/data/file_picker_gallery_service.dart';
import 'package:blog_app/features/media/data/video_compress_miniatura_video_generador.dart';
import 'package:blog_app/features/media/domain/abstractions/igallery_service.dart';
import 'package:blog_app/features/media/domain/abstractions/iminiatura_video_service.dart';
import 'package:blog_app/features/media/presentation/logic/controller/miniatura_controller.dart';
import 'package:get_it/get_it.dart';

extension MediaDependencies on GetIt {
  GetIt addMedia() {
    registerLazySingleton<IGalleryService>(() => FilePickerGalleryService());
    registerLazySingleton<IMiniaturaVideoGenerador>(
      () => VideoCompressMiniaturaGenerador(),
    );
    registerFactory<IMiniaturaFactory>(() => GetItMiniaturaFactory());

    registerLazySingleton(
      () => VideoMiniaturaService(get()),
    );
    registerLazySingleton(
      () => YoutubeMiniaturaService(),
    );
    registerLazySingleton(
      () => ImagenMiniaturaService(),
    );

    registerFactory<IMediaServiceFactory>(() => GetItMediaServiceFactory());

    registerFactory(() => VideoFactory());
    registerFactory(() => ImagenFactory());

    return this;
  }
}
