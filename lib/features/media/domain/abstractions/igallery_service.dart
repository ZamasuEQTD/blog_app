import 'package:blog_app/features/app/clases/failure.dart';
import 'package:dartz/dartz.dart';

import '../models/media.dart';

abstract class IGalleryService {
  Future<Either<Failure, Media?>> pickFile({required List<String> extensions});
  Future<Either<Failure, List<Media>>> pickFiles({
    required List<String> extensions,
    int cantidad = 1,
  });
}
