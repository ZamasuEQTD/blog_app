import 'package:blog_app/src/lib/features/auth/data/development/local_auth_repository.dart';
import 'package:blog_app/src/lib/features/auth/domain/iauth_repository.dart';
import 'package:blog_app/src/lib/features/auth/domain/itoken_decode.dart';
import 'package:blog_app/src/lib/features/auth/domain/itoken_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/data/secure_token_storage.dart';
import '../../features/auth/data/token_decode.dart';

extension AuthDependencies on GetIt {
  GetIt addAuth() {
    registerFactory(() => const FlutterSecureStorage());

    registerFactory<IAuthRepository>(
      () => LocalAuthRepository(),
    );
    registerFactory<ITokenDecode>(() => TokenDecode());

    registerFactory<ITokenStorage>(() => TokenSecureStorage());
    return this;
  }
}
