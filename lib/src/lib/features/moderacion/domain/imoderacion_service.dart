import 'package:blog_app/src/lib/features/moderacion/domain/models/usuario.dart';
import 'package:dartz/dartz.dart';

import '../../../utils/clases/failure.dart';

abstract class IModeracionRepository {
  Future<Either<Failure, Usuario>> verUsuario({
    String usuario,
  });

  Future<Either<Failure, Unit>> banear({
    String usuario,
  });
}
