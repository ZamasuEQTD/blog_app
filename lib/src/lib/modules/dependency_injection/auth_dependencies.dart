import 'package:blog_app/src/lib/features/auth/data/development/local_auth_repository.dart';
import 'package:blog_app/src/lib/features/auth/domain/iauth_repository.dart';
import 'package:get_it/get_it.dart';

extension AuthDependencies on GetIt {
  GetIt addAuth() {
    registerFactory<IAuthRepository>(
      () => LocalAuthRepository(),
    );
    return this;
  }
}
