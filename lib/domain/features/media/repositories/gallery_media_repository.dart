import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/domain/features/media/entities/media.dart';
import 'package:dartz/dartz.dart';

abstract class IGalleryMediaRepository {
  Future<Either<Failure,Media>> pick();
}