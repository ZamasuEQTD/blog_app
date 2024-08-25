import 'package:blog_app/features/media/domain/abstractions/igallery_service.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/classes/failure.dart';
import '../../../../core/usecases/iusecase.dart';
import '../models/media.dart';

class GetGalleryFileUsecase extends IUsecase<GetGalleryFileRequest, Media?> {
  final IGalleryService _repository;

  const GetGalleryFileUsecase(this._repository);

  @override
  Future<Either<Failure, Media?>> handle(GetGalleryFileRequest request) {
    return _repository.pickFile(extensions: request.extensions);
  }
}

class GetGalleryFileRequest {
  final List<String> extensions;

  const GetGalleryFileRequest({required this.extensions});
}
