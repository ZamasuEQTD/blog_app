import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:blog_app/features/auth/domain/usecases/cerrar_sesion_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';

class EstablecerTokenUsecase extends IUsecase<EstablecerTokenRequest, Unit> {
  final ITokenService _token = GetIt.I.get();
  @override
  Future<Either<Failure, Unit>> handle(EstablecerTokenRequest request) async {
    await _token.set(request.token.jwt);

    return const Right(unit);
  }
}

class Token {
  final String jwt;

  const Token({required this.jwt});
}

class EstablecerTokenRequest {
  final Token token;

  EstablecerTokenRequest({required this.token});
}
