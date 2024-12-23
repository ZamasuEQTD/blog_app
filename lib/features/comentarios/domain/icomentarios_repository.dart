import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/app/domain/models/spoileable.dart';
import 'package:blog_app/features/hilos/domain/models/types.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:dartz/dartz.dart';

import 'models/comentario.dart';
import 'models/typedef.dart';

abstract class IComentariosRepository {
  Future<Either<Failure, List<Comentario>>> getComentarios({
    required HiloId hilo,
    String? ultimoComentario,
  });

  Future<Either<Failure, Unit>> enviar({
    required HiloId hilo,
    required String comentario,
    Spoileable<Media>? media,
  });

  Future<Either<Failure, Unit>> eliminar({
    required HiloId hilo,
    required ComentarioId comentario,
  });

  Future<Either<Failure, Unit>> ocultar({
    required HiloId hilo,
    required ComentarioId comentario,
  });

  Future<Either<Failure, Unit>> denunciar({
    required HiloId hilo,
    required ComentarioId comentario,
  });

  Future<Either<Failure, Unit>> destacar({
    required HiloId hilo,
    required ComentarioId comentario,
  });
}
