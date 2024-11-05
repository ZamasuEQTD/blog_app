import 'package:get_it/get_it.dart';

import '../../features/moderacion/data/development/local_moderacion_repository.dart';
import '../../features/moderacion/domain/imoderacion_repository.dart';

extension ModeracionDependencies on GetIt {
  GetIt addModeracion() {
    registerLazySingleton<IModeracionRepository>(
      () => LocalModeracionRepository(),
    );
    return this;
  }
}
