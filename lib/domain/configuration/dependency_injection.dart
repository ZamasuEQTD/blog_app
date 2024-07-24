import 'package:blog_app/domain/features/comentarios/usecases/get_comentarios.dart';
import 'package:blog_app/domain/features/hilo/usecases/comentar_hilo_usecase.dart';
import 'package:blog_app/domain/features/hilo/usecases/get_comentarios_de_hilo_usecase.dart';
import 'package:blog_app/domain/features/hilo/usecases/get_hilo_usecase.dart';
import 'package:blog_app/domain/features/home/usecases/get_home_portadas.dart';
import 'package:get_it/get_it.dart';

extension DependencyInjection on GetIt {
  GetIt addDomain() {
    registerSingleton(GetHomePortadasUseCase(get()));
    registerSingleton(const GetHiloUseCase());
    registerSingleton(GetComentariosUseCase());
    registerSingleton(ComentarHiloUsecase());
    registerSingleton(GetComentariosDeHiloUsecase());
    return this;
  }
}
