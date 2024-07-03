import 'package:blog_app/src/domain/features/hilos/models/hilo.dart';
import 'package:blog_app/src/domain/features/media/models/fuente_de_archivo.dart';
import 'package:blog_app/src/domain/features/media/models/media.dart';
import 'package:blog_app/src/domain/shared/models/spoileable.dart';
import 'package:blog_app/src/infraestructure/features/hilos/abstractions/ihilos_datasource.dart';
import 'package:blog_app/src/shared_kernel/failure.dart';
import 'package:dartz/dartz.dart';

List<Hilo> hilos = [
  Hilo(
    "1",
    "holaaa", 
    "Probandoo",
    DateTime(1999), 
    const BanderasDeHilo(false, false, false),
    EstadoDeHilo.activo, 
    Spoileable(false, Video(NetworkMedia("")))
  ),
  Hilo(
    "2",
    "holaaa", 
    "Probandoo",
    DateTime(1999), 
    const BanderasDeHilo(false, false, false),
    EstadoDeHilo.activo, 
    Spoileable(false, Video(NetworkMedia("")))
  )
];

class HilosLocalDatasource extends IHilosDatasource {
  @override
  Future<Either<Failure, Hilo>> getHilo({required String id}) async {
    try {
      Hilo hilo =  hilos.firstWhere((element) => element.id == id);
      return Right(hilo);
    } catch (e) {
      return const Left(Failure("Hilos.NoEncontrado"));
    }
  }
  
}