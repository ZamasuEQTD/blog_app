import 'package:dartz/dartz.dart';

import '../../../../core/classes/failure.dart';
import '../../../../core/usecases/iusecase.dart';
import '../abstractions/ihome_repository.dart';
import '../models/home_portada_entry.dart';

class GetHomePortadasUseCase
    extends IUsecase<GetHomePortadasRequest, List<HomePortadaEntity>> {
  final IHomeRepository _repository;
  const GetHomePortadasUseCase(this._repository);

  @override
  Future<Either<Failure, List<HomePortadaEntity>>> handle(
      GetHomePortadasRequest request) async {
    return _repository.getPortadas(request);
  }
}
