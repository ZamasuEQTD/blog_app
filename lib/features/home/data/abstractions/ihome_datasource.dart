import 'package:dartz/dartz.dart';

import '../../../../core/classes/failure.dart';
import '../../domain/abstractions/ihome_repository.dart';
import '../../domain/models/home_portada_entry.dart';

abstract class IHomeDatasource {
  Future<Either<Failure, List<HomePortadaEntity>>> getPortadas(
      GetHomePortadasRequest request);
}
