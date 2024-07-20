import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:blog_app/data/features/home/models/get_home_portadas_request.dart';
import 'package:blog_app/domain/features/home/entities/home_portada_de_hilo.dart';
import 'package:blog_app/domain/features/home/repositories/ihome_repository.dart';
import 'package:dartz/dartz.dart';

class GetHomePortadasUseCase extends IUsecase<GetHomePortadasRequest,List<HomePortadaDeHilo>>{
  final IHomeRepository _repository;

  const GetHomePortadasUseCase(this._repository);
  @override
  Future<Either<Failure, List<HomePortadaDeHilo>>> handle(GetHomePortadasRequest request) {
    // TODO: implement handle
    throw UnimplementedError();
  }

}
  

