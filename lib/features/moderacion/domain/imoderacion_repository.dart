import 'package:blog_app/features/app/clases/failure.dart';
import 'package:dartz/dartz.dart';

import 'models/registro_usuario.dart';

abstract class IModeracionRepository {
  Future<Either<Failure, RegistroUsuario>> verUsuario({
    required String usuario,
  });

  Future<Either<Failure, List<HiloComentadoRegistro>>> getComentarioHistorials({
    required String usuario,
    DateTime? ultimo,
  });

  Future<Either<Failure, List<HiloPosteadoRegistro>>> getHistorialHilos({
    required String usuario,
    DateTime? ultimo,
  });
}
