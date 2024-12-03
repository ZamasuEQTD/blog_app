import 'package:blog_app/features/app/clases/failure.dart';
import 'package:dartz/dartz.dart';

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
