import 'package:blog_app/src/lib/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/src/lib/features/hilo/domain/models/types.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IDenunciasRepository {
  Future<Either<Failure, Unit>> denunciarHilo({
    required HiloId id,
  });

  Future<Either<Failure, Unit>> denunciarComentario({
    required ComentarioId id,
  });
}
