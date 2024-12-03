import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/baneos/presentation/screens/logic/controllers/banear_usuario.dart';
import 'package:dartz/dartz.dart';

abstract class IBaneosRepository {
  Future<Either<Failure, Unit>> banear({
    required String id,
    required Razon razon,
    required Duracion duracion,
    String? mensaje,
  });

  Future<Either<Failure, Unit>> desbanear({
    required String id,
  });
}
