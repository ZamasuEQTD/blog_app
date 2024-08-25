import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/classes/failure.dart';

class LoginUsecase extends IUsecase<RegistroRequest, String> {
  @override
  Future<Either<Failure, String>> handle(RegistroRequest request) {
    throw UnimplementedError();
  }
}

class RegistroRequest {
  final String usuario;
  final String password;

  const RegistroRequest({required this.usuario, required this.password});
}
