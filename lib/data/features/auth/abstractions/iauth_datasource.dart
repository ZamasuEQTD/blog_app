import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/data/features/auth/models/login_request.dart';
import 'package:dartz/dartz.dart';

abstract class IAuthDatasource {
  Future<Either<Failure,String>> login(LoginRequest request);
}