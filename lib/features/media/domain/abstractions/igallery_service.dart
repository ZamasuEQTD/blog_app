import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/classes/failure.dart';

abstract class IGalleryService {
  Future<Either<Failure, Media?>> pickFile({required List<String> extensions});
  Future<Either<Failure, List<Media>>> pickFiles(
      {required List<String> extensions, int cantidad = 1});
}
