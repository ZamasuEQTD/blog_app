import 'package:blog_app/src/domain/features/comentarios/models/comentario.dart';

import 'package:blog_app/src/domain/features/hilos/models/types/hilo_id.dart';

import 'package:blog_app/src/shared_kernel/failure.dart';

import 'package:dartz/dartz.dart';

import '../../../domain/features/comentarios/abstractions/icomentarios_repository.dart';

class ComentariosRepository extends IComentariosRepository {
  @override
  Future<Either<Failure, List<Comentario>>> getComentarios({required HiloId id, required int pagina}) {
    throw UnimplementedError();
  }
}