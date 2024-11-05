import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:dartz/dartz.dart';

import '../../../utils/clases/failure.dart';
import '../../app/domain/models/spoileable.dart';
import '../../categorias/domain/models/subcategoria.dart';
import '../../media/domain/models/media.dart';
import 'models/hilo.dart';
import 'models/types.dart';

abstract class IHilosRepository {
  Future<Either<Failure, HiloId>> postear({
    required String titulo,
    required String descripcion,
    required Spoileable<Media> portada,
    required SubcategoriaId subcategoria,
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

  Future<Either<Failure, Unit>> eliminar({
    required String id,
  });

  Future<Either<Failure, Unit>> seguir({
    required String id,
  });

  Future<Either<Failure, Unit>> ponerEnFavoritos({
    required String id,
  });

  Future<Either<Failure, Unit>> ocultar({
    required String id,
  });
}
