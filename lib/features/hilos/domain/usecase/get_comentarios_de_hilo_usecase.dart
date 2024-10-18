import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:blog_app/features/hilos/domain/models/comentario.dart';
import 'package:dartz/dartz.dart';

class GetComentariosDeHiloUsecase
    extends IUsecase<GetComentariosDeHiloRequest, List<ComentarioEntity>> {
  @override
  Future<Either<Failure, List<ComentarioEntity>>> handle(
    GetComentariosDeHiloRequest request,
  ) async {
    return Right([
      ComentarioEntity(
        autor: const Autor(
          nombre: "Gatubi",
          rango: "Moderador",
          rangoCorto: "mod",
        ),
        color: ColoresDeComentario.multi,
        creado_en: DateTime.now(),
        datos: const DatosDeComentario(
          tag: "FASFASF",
          tagUnico: "GGS",
          dados: "2",
        ),
        id: "F",
        texto: ">>FSAFASFF https://google.com",
      ),
    ]);
  }
}

class GetComentariosDeHiloRequest {}
