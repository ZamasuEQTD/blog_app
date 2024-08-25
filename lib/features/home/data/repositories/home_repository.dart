import 'package:dartz/dartz.dart';

import '../../../../core/classes/failure.dart';
import '../../domain/abstractions/ihome_repository.dart';
import '../../domain/models/home_portada_entry.dart';
import '../abstractions/ihome_datasource.dart';

class HomeRepository extends IHomeRepository {
  final IHomeDatasource _datasource;

  HomeRepository(this._datasource);
  @override
  Future<Either<Failure, List<HomePortadaListEntry>>> getPortadas(
      GetHomePortadasRequest request) async {
    return _datasource.getPortadas(request);
  }
}
