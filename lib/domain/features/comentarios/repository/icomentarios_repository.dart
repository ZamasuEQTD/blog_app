import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/domain/features/comentarios/entities/comentario.dart';
import 'package:blog_app/domain/features/comentarios/usecases/get_comentarios.dart';
import 'package:dartz/dartz.dart';

abstract class IComentariosRepository {
  Future<Either<Failure, List<Comentario>>> getComentariosDeHilo(GetComentariosRequest request);
}
