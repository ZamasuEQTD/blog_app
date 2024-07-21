import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';

import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:blog_app/domain/features/media/entities/media.dart';
import 'package:blog_app/domain/features/media/repositories/gallery_media_repository.dart';
import 'package:dartz/dartz.dart';

class GetGalleryFileUsecase extends IUsecase<int,Media> {
  final IGalleryMediaRepository _repository;

  const GetGalleryFileUsecase(this._repository);

  @override
  Future<Either<Failure, Media>> handle(request) {
    return _repository.pick();
  }
}