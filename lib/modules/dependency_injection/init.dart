import 'package:blog_app/features/auth/presentation/logic/controllers/auth_controller.dart';
import 'package:blog_app/modules/config/api_config.dart';
import 'package:blog_app/modules/dependency_injection/auth_dependencies.dart';
import 'package:blog_app/modules/dependency_injection/baneos_dependencies.dart';
import 'package:blog_app/modules/dependency_injection/categorias_dependencies.dart';
import 'package:blog_app/modules/dependency_injection/comentarios_dependencies.dart';
import 'package:blog_app/modules/dependency_injection/hilos_dependencies.dart';
import 'package:blog_app/modules/dependency_injection/media_dependencies.dart';
import 'package:blog_app/modules/dependency_injection/moderacion_dependencies.dart';
import 'package:blog_app/modules/dependency_injection/notificaciones_dependencies.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

extension InitDependencies on GetIt {
  GetIt addDepedencies() {
    addMedia()
        .addHilos()
        .addComentarios()
        .addAuth()
        .addNotificaciones()
        .addModeracion()
        .addCategorias()
        .addBaneos();
    registerFactory<Dio>(
      () => Dio(
        BaseOptions(
          baseUrl: ApiConfig.api,
          headers: {
            if (GetIt.I.get<AuthController>().token.value != null)
              "Authorization":
                  "Bearer ${GetIt.I.get<AuthController>().token.value}",
          },
        ),
      ),
    );

    return this;
  }
}
