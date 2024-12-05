import 'package:blog_app/features/moderacion/data/dio_moderacion_repository.dart';
import 'package:blog_app/features/moderacion/domain/imoderacion_repository.dart';
import 'package:get_it/get_it.dart';

extension ModeracionDependencies on GetIt {
  GetIt addModeracion() {
    registerLazySingleton<IModeracionRepository>(
      () => DioModeracionRepository(),
    );

    return this;
  }
}
