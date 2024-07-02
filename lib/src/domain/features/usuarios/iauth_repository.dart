import 'package:dartz/dartz.dart';

import '../../../shared_kernel/failure.dart';

abstract class IAuthRepository {
  Future<Either<Failure, String>> registrase({
    required String username,
    required String password,
  });
  
  Future<Either<Failure, String>> login({
    required String username,
    required String password,
  });
}
abstract class ITokenRepository {
  Future<void> setToken(String token);
  Future<String?> getActualToken(); 
  Future<void> delToken();
}