import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:blog_app/features/auth/domain/usecases/cerrar_sesion_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';

import 'establecer_token_usecase.dart';

class GetUltimaSesionUsecase extends IUsecase<GetUltimaSesionRequest, Token?> {
  final ITokenService tokenService = GetIt.I.get();
  @override
  Future<Either<Failure, Token?>> handle(GetUltimaSesionRequest request) async {
    return Right(await tokenService.getToken());
  }
}

class GetUltimaSesionRequest {}
