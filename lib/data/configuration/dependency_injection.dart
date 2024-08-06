import 'package:blog_app/data/features/home/abstractions/ihome_datasource.dart';
import 'package:blog_app/data/features/home/datasources/local_home_datasource.dart';
import 'package:blog_app/data/features/home/repositories/home_repository.dart';
import 'package:blog_app/data/features/media/abstractions/gallery_media_datasource.dart';
import 'package:blog_app/data/features/media/datasources/file_picker_gallery_media_datasource.dart';
import 'package:blog_app/data/features/media/repositories/gallery_media_repository.dart';
import 'package:blog_app/domain/features/home/repositories/ihome_repository.dart';
import 'package:blog_app/domain/features/media/repositories/gallery_media_repository.dart';
import 'package:get_it/get_it.dart';

extension DependencyInjection on GetIt {
  GetIt addData(){
    registerLazySingleton<IHomeRepository>(() => HomeRepository(get()));
    registerLazySingleton<IHomeDatasource>(()=> LocalHomeDatasource());
    registerLazySingleton<IGalleryMediaRepository>(()=> GalleryMediaRepository(get()));
    registerLazySingleton<IGalleryMediaDatasource>(() => FilePickerGalleryMediaDatasource());

    return this;
 }
}