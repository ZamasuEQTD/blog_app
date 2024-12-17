import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:dartz/dartz.dart';

abstract class IColeccionesHilosRepository {
  Future<Either<Failure, List<PortadaHilo>>> favoritos();
  Future<Either<Failure, List<PortadaHilo>>> seguidos();
  Future<Either<Failure, List<PortadaHilo>>> ocultos();
}
