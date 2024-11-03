import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:dartz/dartz.dart';

import '../../../utils/clases/failure.dart';
import '../../app/domain/models/spoileable.dart';
import '../../media/domain/models/media.dart';
import 'models/hilo.dart';
import 'models/types.dart';

abstract class IHilosRepository {
  Future<Either<Failure, HiloId>> postear({
    required String titulo,
    required String descripcion,
    required Spoileable<Media> portada,
    required List<String> encuesta,
    required bool dados,
    required bool idUnico,
  });

  Future<Either<Failure, Hilo>> getHilo({
    required String id,
  });

  Future<Either<Failure, List<HomePortada>>> getPortadas({
    DateTime? ultimoBump,
  });

  Future<Either<Failure, void>> eliminar({
    required String id,
  });

  Future<Either<Failure, void>> seguir({
    required String id,
  });

  Future<Either<Failure, void>> ponerEnFavoritos({
    required String id,
  });

  Future<Either<Failure, void>> ocultar({
    required String id,
  });
}
