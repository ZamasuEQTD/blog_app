import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/data/features/auth/models/login_request.dart';
import 'package:blog_app/data/features/auth/models/registro_request.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthRepository {
  Future<Either<Failure,String>> login(LoginRequest request);
  Future<Either<Failure,String>> registro(RegistroRequest request);
}