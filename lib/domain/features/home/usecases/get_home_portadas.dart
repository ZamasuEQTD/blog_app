import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:blog_app/data/features/home/models/get_home_portadas_request.dart';
import 'package:blog_app/domain/features/common/entities/spoileable.dart';
import 'package:blog_app/domain/features/home/entities/home_portada_de_hilo.dart';
import 'package:blog_app/domain/features/home/repositories/ihome_repository.dart';
import 'package:blog_app/domain/features/media/entities/media.dart';
import 'package:dartz/dartz.dart';

class GetHomePortadasUseCase extends IUsecase<GetHomePortadasRequest,List<HomePortadaDeHilo>>{
  final IHomeRepository? _repository = null;

  const GetHomePortadasUseCase( );
  @override
  Future<Either<Failure, List<HomePortadaDeHilo>>> handle(GetHomePortadasRequest request) async{
    await Future.delayed(const Duration(seconds: 3));
    return   Right([
      HomePortadaDeHilo(id: "", titulo: "titulo", ultimoBump: DateTime.now(), banderas: HomePortadaDeHiloBanderas(), portada: const Spoileable(false, Imagen(datos: DatosDeImagen(source: NetworkMediaProvider(url: "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"))))),
      HomePortadaDeHilo(id: "", titulo: "titulo", ultimoBump: DateTime.now(), banderas: HomePortadaDeHiloBanderas(), portada: const Spoileable(false, Imagen(datos: DatosDeImagen(source: NetworkMediaProvider(url: "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"))))),
      HomePortadaDeHilo(id: "", titulo: "titulo", ultimoBump: DateTime.now(), banderas: HomePortadaDeHiloBanderas(), portada: const Spoileable(false, Imagen(datos: DatosDeImagen(source: NetworkMediaProvider(url: "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"))))),
      HomePortadaDeHilo(id: "", titulo: "titulo", ultimoBump: DateTime.now(), banderas: HomePortadaDeHiloBanderas(), portada: const Spoileable(false, Imagen(datos: DatosDeImagen(source: NetworkMediaProvider(url: "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"))))),
      HomePortadaDeHilo(id: "", titulo: "titulo", ultimoBump: DateTime.now(), banderas: HomePortadaDeHiloBanderas(), portada: const Spoileable(false, Imagen(datos: DatosDeImagen(source: NetworkMediaProvider(url: "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"))))),
      HomePortadaDeHilo(id: "", titulo: "titulo", ultimoBump: DateTime.now(), banderas: HomePortadaDeHiloBanderas(), portada: const Spoileable(false, Imagen(datos: DatosDeImagen(source: NetworkMediaProvider(url: "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"))))),
      HomePortadaDeHilo(id: "", titulo: "titulo", ultimoBump: DateTime.now(), banderas: HomePortadaDeHiloBanderas(), portada: const Spoileable(false, Imagen(datos: DatosDeImagen(source: NetworkMediaProvider(url: "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"))))),
      HomePortadaDeHilo(id: "", titulo: "titulo", ultimoBump: DateTime.now(), banderas: HomePortadaDeHiloBanderas(), portada: const Spoileable(false, Imagen(datos: DatosDeImagen(source: NetworkMediaProvider(url: "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"))))),
    ]);
  }

}
  

