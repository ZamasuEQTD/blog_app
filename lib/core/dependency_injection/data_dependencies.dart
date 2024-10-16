import 'package:blog_app/features/hilos/domain/usecase/get_comentarios_de_hilo_usecase.dart';
import 'package:blog_app/features/hilos/domain/usecase/get_hilo_usecase.dart';
import 'package:blog_app/features/hilos/domain/usecase/postear_hilo_usecase.dart';
import 'package:blog_app/features/hilos/presentation/logic/bloc/postear_hilo/postear_hilo_bloc.dart';
import 'package:blog_app/features/home/data/abstractions/ihome_datasource.dart';
import 'package:blog_app/features/home/data/datasources/local_home_datasource.dart';
import 'package:blog_app/features/home/data/datasources/local_home_hub.dart';
import 'package:blog_app/features/home/data/repositories/home_repository.dart';
import 'package:blog_app/features/home/domain/abstractions/ihome_hub.dart';
import 'package:blog_app/features/home/domain/abstractions/ihome_repository.dart';
import 'package:blog_app/features/home/domain/usecases/get_home_portadas.dart';
import 'package:blog_app/features/media/data/services/file_picker_gallery_service.dart';
import 'package:blog_app/features/media/domain/abstractions/igallery_service.dart';
import 'package:blog_app/features/media/domain/usecases/get_gallery_file_usecase.dart';
import 'package:blog_app/features/media/presentation/widgets/miniatura/miniatura.dart';
import 'package:get_it/get_it.dart';

extension DataDependencies on GetIt {
  GetIt addData() {
    _addHome();
    _addPostearHilo();
    _addHilo();
    return this;
  }

  GetIt _addPostearHilo() {
    registerFactory(() => GetGalleryFileUsecase(get()));
    registerLazySingleton<IMediaFactory>(() => MediaFactory());
    registerFactory<IGalleryService>(() => FilePickerGalleryService());
    registerFactory<PostearHiloUsecase>(() => PostearHiloUsecase());
    return this;
  }

  GetIt _addHome() {
    registerFactory<IHomeDatasource>(() => LocalHomeDatasource());
    registerFactory<IHomeRepository>(() => HomeRepository(get()));
    registerFactory<GetHomePortadasUseCase>(
      () => GetHomePortadasUseCase(get()),
    );
    registerFactory<IHomeHub>(() => LocalHomeHub());

    return this;
  }

  GetIt _addHilo() {
    a();
    registerFactory(() => const GetHiloUseCase());
    registerFactory(() => GetComentariosDeHiloUsecase());
    return this;
  }
}

extension iDS on GetIt {
  GetIt a() {
    registerFactory(
      () => MiniaturaStrategyContext(),
    );
    registerFactory<IMiniaturaVideoGenerador>(
      () => VideoCompressMiniaturaGenerador(),
    );

    registerFactory<IMiniaturaStrategy>(
      () => VideoMiniaturaStrategy(get()),
      instanceName: "video",
    );

    registerFactory<IMiniaturaStrategy>(
      () => ImagenMiniaturaStrategy(),
      instanceName: "imagen",
    );

    return this;
  }
}
