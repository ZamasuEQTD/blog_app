import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';

import 'establecer_token_usecase.dart';

class CerrarSesionUsecase extends IUsecase<CerrarSesionRequest, Unit> {
  final ITokenService _token = GetIt.I.get();

  @override
  Future<Either<Failure, Unit>> handle(CerrarSesionRequest request) async {
    await _token.eliminar();

    return const Right(unit);
  }
}

class CerrarSesionRequest {}

abstract class ITokenService {
  Future<void> eliminar();
  Future<void> set(String token);
  Future<bool> existeToken();
  Future<Token?> getToken();
}
