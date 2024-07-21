
import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/data/features/home/abstractions/ihome_datasource.dart';
import 'package:blog_app/data/features/home/models/get_home_portadas_request.dart';
import 'package:blog_app/domain/features/home/entities/home_portada_de_hilo.dart';
import 'package:blog_app/domain/features/home/repositories/ihome_repository.dart';
import 'package:dartz/dartz.dart';

class HomeRepository extends IHomeRepository {
  
  final IHomeDatasource _datasource;

  HomeRepository(this._datasource);
  @override
  Future<Either<Failure, List<HomePortadaDeHilo>>> getPortadas(GetHomePortadasRequest request) async {
    return _datasource.getPortadas(request);
  }
}