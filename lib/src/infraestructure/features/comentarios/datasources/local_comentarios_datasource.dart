import 'package:blog_app/src/domain/features/comentarios/models/comentario.dart';
import 'package:blog_app/src/domain/features/hilos/models/types/hilo_id.dart';
import 'package:blog_app/src/infraestructure/features/comentarios/abstractions/icomentarios_datasource.dart';
import 'package:blog_app/src/shared_kernel/failure.dart';
import 'package:dartz/dartz.dart';

class ComentariosLocalDatasource extends IComentariosDatasource {
  @override
  Future<Either<Failure, List<Comentario>>> getComentarios({required HiloId id, required int pagina})async {
    return Right([
      Comentario(id: "1", texto: "texto", createdAt: DateTime.now(), datos: const DatosDeComentario(tag: "FSAFAS", tagUnico:"RDS", dados: "4"),media: null),
      Comentario(id: "2", texto: "texto", createdAt: DateTime.now(), datos: const DatosDeComentario(tag: "FSAFAS", tagUnico:"RDS", dados: "4"),media: null),
      Comentario(id: "3", texto: "texto", createdAt: DateTime.now(), datos: const DatosDeComentario(tag: "FSAFAS", tagUnico:"RDS", dados: "4"),media: null),
      Comentario(id: "421", texto: "texto", createdAt: DateTime.now(), datos: const DatosDeComentario(tag: "FSAFAS", tagUnico:"RDS", dados: "4"),media: null),
      Comentario(id: "212", texto: "texto", createdAt: DateTime.now(), datos: const DatosDeComentario(tag: "FSAFAS", tagUnico:"RDS", dados: "4"),media: null),
      Comentario(id: "254", texto: "texto", createdAt: DateTime.now(), datos: const DatosDeComentario(tag: "FSAFAS", tagUnico:"RDS", dados: "4"),media: null),
      Comentario(id: "21", texto: "texto", createdAt: DateTime.now(), datos: const DatosDeComentario(tag: "FSAFAS", tagUnico:"RDS", dados: "4"),media: null),
      Comentario(id: "23", texto: "texto", createdAt: DateTime.now(), datos: const DatosDeComentario(tag: "FSAFAS", tagUnico:"RDS", dados: "4"),media: null),
      Comentario(id: "22 ", texto: "texto", createdAt: DateTime.now(), datos: const DatosDeComentario(tag: "FSAFAS", tagUnico:"RDS", dados: "4"),media: null),
      Comentario(id: "22  ", texto: "texto", createdAt: DateTime.now(), datos: const DatosDeComentario(tag: "FSAFAS", tagUnico:"RDS", dados: "4"),media: null),
      Comentario(id: "22 23", texto: "texto", createdAt: DateTime.now(), datos: const DatosDeComentario(tag: "FSAFAS", tagUnico:"RDS", dados: "4"),media: null),
      Comentario(id: "22 ss", texto: "texto", createdAt: DateTime.now(), datos: const DatosDeComentario(tag: "FSAFAS", tagUnico:"RDS", dados: "4"),media: null),
      Comentario(id: "22 a", texto: "texto", createdAt: DateTime.now(), datos: const DatosDeComentario(tag: "FSAFAS", tagUnico:"RDS", dados: "4"),media: null)

    ]);
  }
  
}