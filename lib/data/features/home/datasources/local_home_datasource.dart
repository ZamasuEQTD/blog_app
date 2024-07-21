import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/data/features/home/abstractions/ihome_datasource.dart';
import 'package:blog_app/data/features/home/models/get_home_portadas_request.dart';
import 'package:blog_app/domain/features/common/entities/spoileable.dart';
import 'package:blog_app/domain/features/home/entities/home_portada_de_hilo.dart';
import 'package:blog_app/domain/features/media/entities/media.dart';
import 'package:dartz/dartz.dart';

final List<HomePortadaDeHilo> portadas = [
  HomePortadaDeHilo(id: "1", titulo: "titulo",subcategoria: "NSFW", ultimoBump: DateTime(1999,DateTime.april,DateTime.friday,2,22), banderas: HomePortadaDeHiloBanderas(esNuevo:  false), portada: const Spoileable(false, Imagen(datos: DatosDeImagen(source: NetworkMediaProvider(url: "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"))))),
  HomePortadaDeHilo(id: "2", titulo: "titulo",subcategoria: "NSFW", ultimoBump: DateTime.now().subtract(const Duration(days: 60)), banderas: HomePortadaDeHiloBanderas(esNuevo:  false), portada: const Spoileable(true, Imagen(datos: DatosDeImagen(source: NetworkMediaProvider(url: "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"))))),
  HomePortadaDeHilo(id: "3", titulo: "titulo",subcategoria: "NSFW", ultimoBump: DateTime.now().subtract(const Duration(minutes: 30)), banderas: HomePortadaDeHiloBanderas(esNuevo:  false), portada: const Spoileable(false, Imagen(datos: DatosDeImagen(source: NetworkMediaProvider(url: "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"))))),
  HomePortadaDeHilo(id: "4", titulo: "titulo",subcategoria: "NSFW", ultimoBump: DateTime.now(), banderas: HomePortadaDeHiloBanderas(esNuevo:  false), portada: const Spoileable(true, Imagen(datos: DatosDeImagen(source: NetworkMediaProvider(url: "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"))))),
  HomePortadaDeHilo(id: "5", titulo: "titulo",subcategoria: "NSFW", ultimoBump: DateTime.now(), banderas: HomePortadaDeHiloBanderas(esNuevo:  false), portada: const Spoileable(false, Imagen(datos: DatosDeImagen(source: NetworkMediaProvider(url: "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"))))),
  HomePortadaDeHilo(id: "6", titulo: "titulo",subcategoria: "NSFW", ultimoBump: DateTime.now(), banderas: HomePortadaDeHiloBanderas(esNuevo:  false), portada: const Spoileable(false, Imagen(datos: DatosDeImagen(source: NetworkMediaProvider(url: "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"))))),
  HomePortadaDeHilo(id: "7", titulo: "titulo",subcategoria: "NSFW", ultimoBump: DateTime.now(), banderas: HomePortadaDeHiloBanderas(esNuevo:  false), portada: const Spoileable(false, Imagen(datos: DatosDeImagen(source: NetworkMediaProvider(url: "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"))))),
  HomePortadaDeHilo(id: "8", titulo: "titulo",subcategoria: "NSFW", ultimoBump: DateTime.now(), banderas: HomePortadaDeHiloBanderas(esNuevo:  false), portada: const Spoileable(false, Imagen(datos: DatosDeImagen(source: NetworkMediaProvider(url: "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"))))),
];

class LocalHomeDatasource extends IHomeDatasource {
  @override
  Future<Either<Failure, List<HomePortadaDeHilo>>> getPortadas(GetHomePortadasRequest request) async {
    await Future.delayed(Duration(seconds: 3));
    return Right(portadas);
  }
}