import 'package:blog_app/features/auth/data/dio_auth_repository.dart';
import 'package:blog_app/features/auth/domain/iauth_repository.dart';
import 'package:blog_app/features/auth/domain/itoken_decode.dart';
import 'package:blog_app/features/auth/domain/itoken_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/secure_token_storage.dart';
import '../../features/auth/data/token_decode.dart';
import '../../features/auth/presentation/logic/controllers/auth_controller.dart';

extension AuthDependencies on GetIt {
  GetIt addAuth() {
    registerFactory(() => const FlutterSecureStorage());

    registerFactory<IAuthRepository>(
      () => DioAuthRepository(),
    );

    registerLazySingleton<AuthController>(() => AuthController());

    //registerFactory<ITokenDecode>(() => LocalTokenDecode());
    registerFactory<ITokenDecode>(() => TokenDecode());

    registerFactory<ITokenStorage>(() => TokenSecureStorage());
    return this;
  }
}
