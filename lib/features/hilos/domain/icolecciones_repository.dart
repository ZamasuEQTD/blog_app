import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:dartz/dartz.dart';

import '../../colecciones/presentation/logic/controllers/coleccion_controller.dart';

abstract class IColeccionesHilosRepository {
  Future<Either<Failure, List<PortadaHilo>>> getColeccion({
    required Coleccion coleccion,
    String? ultimo,
  });
}
