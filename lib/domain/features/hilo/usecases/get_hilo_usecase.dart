import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:blog_app/data/features/hilo/models/get_hilo_request.dart';
import 'package:blog_app/domain/features/comentarios/usecases/get_comentarios.dart';
import 'package:blog_app/domain/features/common/entities/spoileable.dart';
import 'package:blog_app/domain/features/hilo/entities/hilo.dart';
import 'package:blog_app/domain/features/media/entities/media.dart';
import 'package:dartz/dartz.dart';

class GetHiloUseCase extends IUsecase<GetHiloRequest, Hilo>{

  const GetHiloUseCase();

  @override
  Future<Either<Failure, Hilo>> handle(GetHiloRequest request) async{
    await Future.delayed(const Duration(seconds: 3));
    return Right(Hilo(id: "id", titulo: "titulo", descripcion: "descripcion", createdAt: DateTime.now(), banderas: const BanderasDeHilo(false,false, false), archivo: const Spoileable(false, Imagen(datos: DatosDeImagen(source: NetworkMediaProvider(url: "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696")))), estado: EstadoDeHilo.activo));
  }
}

