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
    Spoileable(false, Imagen(NetworkMedia("https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696")))),
  Hilo(
    "2",
    "holaaa", 
    "Probandoo",
    DateTime(1999), 
    const BanderasDeHilo(false, false, false),
    EstadoDeHilo.activo, 
    Spoileable(false, Imagen(NetworkMedia("https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696")))
  )
];

class HilosLocalDatasource extends IHilosDatasource {
  @override
  Future<Either<Failure, Hilo>> getHilo({required String id}) async {

    await Future.delayed(const Duration(seconds: 3));
    try {
      Hilo hilo =  hilos.firstWhere((element) => element.id == id);
      return Right(hilo);
    } catch (e) {
      return const Left(Failure("Hilos.NoEncontrado"));
    }
  }
  
}