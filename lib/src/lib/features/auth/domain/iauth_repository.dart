import 'package:dartz/dartz.dart';

import '../../../utils/clases/failure.dart';

abstract class IAuthRepository {
  Future<Either<Failure, String>> login({
    String usuario,
    String password,
  });
  Future<Either<Failure, String>> registro({
    String usuario,
    String password,
  });
}
