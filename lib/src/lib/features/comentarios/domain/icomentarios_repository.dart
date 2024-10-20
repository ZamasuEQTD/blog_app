import 'package:dartz/dartz.dart';

import '../../../utils/clases/failure.dart';
import '../../hilo/domain/models/types.dart';
import 'models/comentario.dart';

abstract class IComentariosRepository {
  Future<Either<Failure, List<Comentario>>> getComentarios({
    required HiloId hilo,
    DateTime? ultimoComentario,
  });
}
