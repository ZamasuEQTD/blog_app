import 'package:dartz/dartz.dart';

import '../../../../core/classes/failure.dart';
import '../../domain/abstractions/ihome_repository.dart';
import '../../domain/models/home_portada_entry.dart';
import '../abstractions/ihome_datasource.dart';

class LocalHomeDatasource extends IHomeDatasource {
  @override
  Future<Either<Failure, List<HomePortadaListEntry>>> getPortadas(
      GetHomePortadasRequest request) async {
    await Future.delayed(const Duration(seconds: 3));
    return const Right([]);
  }
}
