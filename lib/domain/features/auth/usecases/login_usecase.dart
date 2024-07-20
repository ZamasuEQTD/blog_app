import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:blog_app/domain/features/auth/entities/usuario.dart';
import 'package:blog_app/domain/features/auth/repositories/auth_repository.dart';
import 'package:blog_app/domain/features/auth/usecases/registro_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../data/features/auth/models/login_request.dart';

class LoginUsecase extends IUsecase<LoginRequest,Usuario> {
  final IAuthRepository _authRepository;
  final IJwtDecoder _decoder;
  
  const  LoginUsecase(
    this._authRepository, 
    this._decoder
  );
 
  @override
  Future<Either<Failure, Usuario>> handle(LoginRequest request) async {
    var result = await _authRepository.login(request);
    
    return result.fold(
      (l) => Left(l), 
      (r) => Right(_decoder.decode(r))
    );
  }
}