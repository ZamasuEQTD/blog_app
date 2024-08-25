import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

class LoginUsecase extends IUsecase<LoginRequest, String> {
  @override
  Future<Either<Failure, String>> handle(LoginRequest request) {
    // TODO: implement handle
    throw UnimplementedError();
  }
}

class LoginRequest {
  final String usuario;
  final String password;

  LoginRequest({required this.usuario, required this.password});
}
