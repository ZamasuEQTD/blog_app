import 'package:blog_app/src/lib/features/auth/domain/iauth_repository.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:dartz/dartz.dart';

class LocalAuthRepository extends IAuthRepository {
  @override
  Future<Either<Failure, String>> login({
    required String usuario,
    required String password,
  }) {
    return Future.value(const Right("token"));
  }

  @override
  Future<Either<Failure, String>> registro({
    required String usuario,
    required String password,
  }) {
    return Future.value(const Right("token"));
  }
}
