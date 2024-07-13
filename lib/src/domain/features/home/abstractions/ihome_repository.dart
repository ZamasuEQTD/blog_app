import 'package:blog_app/src/domain/features/home/models/portada.dart';
import 'package:blog_app/src/shared_kernel/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IHomeRepository  {
 Future<Either<Failure, List<PortadaHome>>> getPortadas();
}