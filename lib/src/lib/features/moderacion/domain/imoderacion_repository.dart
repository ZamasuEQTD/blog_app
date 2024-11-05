import 'package:blog_app/src/lib/features/moderacion/domain/models/usuario.dart';
import 'package:dartz/dartz.dart';

import '../../../utils/clases/failure.dart';
import 'models/registro_de_comentario.dart';
import 'models/registro_de_hilo.dart';

abstract class IModeracionRepository {
  Future<Either<Failure, Usuario>> verUsuario({
    required String usuario,
  });

  Future<Either<Failure, List<ComentarioHistorial>>> getComentarioHistorials({
    required String usuario,
    DateTime? ultimo,
  });

  Future<Either<Failure, List<HiloHistorial>>> getHistorialHilos({
    required String usuario,
    DateTime? ultimo,
  });
}
