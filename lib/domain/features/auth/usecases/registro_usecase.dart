import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:blog_app/data/features/auth/models/registro_request.dart';
import 'package:blog_app/domain/features/auth/entities/usuario.dart';
import 'package:blog_app/domain/features/auth/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class RegistroUsecase extends IUsecase<RegistroRequest, Usuario> {
  final IAuthRepository _authRepository;
  final IJwtDecoder _decoder;
  RegistroUsecase(this._authRepository, this._decoder);
  @override
  Future<Either<Failure, Usuario>> handle(RegistroRequest request) async{
    var result = await _authRepository.registro(request);

    return result.fold(
      (l) => Left(l),
      (r) => Right(_decoder.decode(r))
    );
  }
}
abstract class IJwtDecoder {
  Usuario decode(String jwt);
}