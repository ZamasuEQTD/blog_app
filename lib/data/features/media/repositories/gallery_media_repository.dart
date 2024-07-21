import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/data/features/media/abstractions/gallery_media_datasource.dart';
import 'package:blog_app/domain/features/media/entities/media.dart';
import 'package:blog_app/domain/features/media/repositories/gallery_media_repository.dart';
import 'package:dartz/dartz.dart';

class GalleryMediaRepository extends IGalleryMediaRepository {

  final IGalleryMediaDatasource _datasource;

  GalleryMediaRepository(this._datasource);
  
  @override
  Future<Either<Failure, Media<DatosDeMedia>>> pick() {
    return _datasource.pick();
  }
}