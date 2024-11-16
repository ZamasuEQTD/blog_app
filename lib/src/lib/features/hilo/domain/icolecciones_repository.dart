import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IColeccionesHilosRepository {
  Future<Either<Failure, List<Portada>>> creados();
  Future<Either<Failure, List<Portada>>> favoritos();
  Future<Either<Failure, List<Portada>>> seguidos();
}
