import 'package:blog_app/src/lib/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/src/lib/features/media/domain/models/media.dart';
import 'package:dartz/dartz.dart';

import '../../../utils/clases/failure.dart';
import '../../hilo/domain/models/types.dart';
import 'models/comentario.dart';

abstract class IComentariosRepository {
  Future<Either<Failure, List<Comentario>>> getComentarios({
    required HiloId hilo,
    DateTime? ultimoComentario,
  });

  Future<Either<Failure, Unit>> enviar({
    required HiloId hilo,
    required String comentario,
    Media? media,
  });

  Future<Either<Failure, Unit>> eliminar({
    required ComentarioId comentario,
  });
}
