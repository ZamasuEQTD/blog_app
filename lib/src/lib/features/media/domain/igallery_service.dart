import 'package:dartz/dartz.dart';

import '../../../utils/clases/failure.dart';
import 'models/media.dart';

abstract class IGalleryService {
  Future<Either<Failure, Media?>> pickFile({required List<String> extensions});
  Future<Either<Failure, List<Media>>> pickFiles({
    required List<String> extensions,
    int cantidad = 1,
  });
}
