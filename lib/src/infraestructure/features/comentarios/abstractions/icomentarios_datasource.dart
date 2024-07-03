import 'package:blog_app/src/domain/features/comentarios/models/comentario.dart';
import 'package:blog_app/src/shared_kernel/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../domain/features/hilos/models/types/hilo_id.dart';

abstract class IComentariosDatasource {
   Future<Either<Failure, List<Comentario>>> getComentarios({required HiloId id, required int pagina});
}