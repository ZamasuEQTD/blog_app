import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/data/features/home/models/get_home_portadas_request.dart';
import 'package:blog_app/domain/features/home/entities/home_portada_de_hilo.dart';
import 'package:dartz/dartz.dart';

abstract class IHomeDatasource {
  Future<Either<Failure,List<HomePortadaDeHilo>>> getPortadas(GetHomePortadasRequest request);
}