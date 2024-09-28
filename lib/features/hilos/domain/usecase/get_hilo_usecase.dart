import 'package:blog_app/common/logic/classes/spoileable.dart';
import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:blog_app/features/categorias/domain/models/subcategoria.dart';
import 'package:blog_app/features/hilos/domain/models/hilo.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:dartz/dartz.dart';

class GetHiloUseCase extends IUsecase<GetHiloRequest, Hilo> {
  const GetHiloUseCase();

  @override
  Future<Either<Failure, Hilo>> handle(GetHiloRequest request) async {
    await Future.delayed(const Duration(seconds: 3));
    return Right(Hilo(
        comentarios: 20,
        esOp: false,
        id: "id",
        titulo: "titulo",
        descripcion: "descripcion",
        estado: EstadoDeHilo.activo,
        creadoEn: DateTime.now().toUtc(),
        banderas: [
          BanderasDeHilo.dados,
          BanderasDeHilo.encuesta,
          BanderasDeHilo.idUnico
        ],
        categoria: Subcategoria(
            "id",
            "NSFW",
            Imagen(
                provider: const NetworkProvider(
                    path: "https://i.redd.it/eopud74baswa1.png"))),
        portada: const Spoileable(
            false,
            Video(
                previsualizacion: "https://i.redd.it/eopud74baswa1.png",
                provider: NetworkProvider(
                    path:
                        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4")))));
  }
}

class GetHiloRequest {
  final HiloId id;

  const GetHiloRequest({required this.id});
}
