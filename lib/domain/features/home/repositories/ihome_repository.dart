import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/domain/features/home/entities/home_portada_de_hilo.dart';
import 'package:dartz/dartz.dart';

abstract class IHomeRepository  {
 Future<Either<Failure, List<HomePortadaDeHilo>>> getPortadas();
}