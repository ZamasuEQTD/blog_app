import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:blog_app/features/auth/domain/models/usuario.dart';
import 'package:blog_app/features/auth/domain/usecases/cerrar_sesion_usecase.dart';
import 'package:blog_app/features/auth/domain/usecases/establecer_token_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';

class DecodeTokenUsecase extends IUsecase<DecodeTokenRequest, Usuario> {
  final ITokenDecoder _decoder = GetIt.I.get();
  @override
  Future<Either<Failure, Usuario>> handle(DecodeTokenRequest request) async {
    return Right(await _decoder.decode(request.token));
  }
}

abstract class ITokenDecoder {
  Future<Usuario> decode(String token);
}

class DecodeTokenRequest {
  final String token;

  const DecodeTokenRequest({required this.token});
}
