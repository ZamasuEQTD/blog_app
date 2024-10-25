import 'package:dartz/dartz.dart';

import '../../../utils/clases/failure.dart';

abstract class IAuthRepository {
  Future<Either<Failure, String>> login({
    required String usuario,
    required String password,
  });
  Future<Either<Failure, String>> registro({
    required String usuario,
    required String password,
  });
}
