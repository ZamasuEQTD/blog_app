import 'package:dartz/dartz.dart';

import '../../../utils/clases/failure.dart';
import 'models/hilo.dart';
import 'models/types.dart';

abstract class IHilosRepository {
  Future<Either<Failure, HiloId>> postear({
    required String titulo,
    required String descripcion,
  });

  Future<Either<Failure, Hilo>> getHilo({
    required String id,
  });
}
