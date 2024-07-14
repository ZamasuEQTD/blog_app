import 'package:blog_app/src/domain/features/home/abstractions/ihome_repository.dart';
import 'package:blog_app/src/domain/features/home/models/portada.dart';
import 'package:blog_app/src/domain/features/media/models/fuente_de_archivo.dart';
import 'package:blog_app/src/domain/features/media/models/media.dart';
import 'package:blog_app/src/domain/shared/models/spoileable.dart';
import 'package:blog_app/src/shared_kernel/failure.dart';
import 'package:dartz/dartz.dart';

class HomeRepository extends IHomeRepository {
  @override
  Future<Either<Failure, List<PortadaHome>>> getPortadas() async {
    return Right( _get());
  }
  List<PortadaHome> _get() =>[for(var i = 0; i< 13; i++) PortadaHome(id: "id", titulo: "titulo", categoria: "categoria", banderas: const PortadaHomeBanderas(
        dadosActivados: false,
        esNuevo: false,
        idUnicoActivado: false,
        tieneEncuesta: false
      ), imagen: Spoileable(true,
      Imagen(NetworkMedia(
        "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"
      ))), ultimoBump: DateTime.now())];
}