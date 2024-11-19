import 'package:blog_app/src/lib/features/app/api_config.dart';
import 'package:blog_app/src/lib/features/app/domain/abstractions/istrategy_context.dart';
import 'package:blog_app/src/lib/features/app/domain/strategy_context.dart';
import 'package:blog_app/src/lib/features/auth/presentation/logic/controlls/auth_controller.dart';
import 'package:blog_app/src/lib/modules/dependency_injection/auth_dependencies.dart';
import 'package:blog_app/src/lib/modules/dependency_injection/comentarios_dependencies.dart';
import 'package:blog_app/src/lib/modules/dependency_injection/hilos_dependencies.dart';
import 'package:blog_app/src/lib/modules/dependency_injection/media_dependencies.dart';
import 'package:blog_app/src/lib/modules/dependency_injection/moderacion_dependencies.dart';
import 'package:blog_app/src/lib/modules/dependency_injection/notificaciones_dependencies.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

extension InitDependencies on GetIt {
  GetIt addDepedencies() {
    addStrategyContext()
        .addMedia()
        .addHilos()
        .addComentarios()
        .addAuth()
        .addNotificaciones()
        .addModeracion();
    registerLazySingleton<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: ApiConfig.api,
          headers: {
            "Authorization":
                "Bearer ${GetIt.I.get<AuthController>().token.value}",
          },
        ),
      ),
    );

    return this;
  }

  GetIt addStrategyContext() {
    registerFactory<IStrategyContext>(() => StrategyContext());
    return this;
  }
}
