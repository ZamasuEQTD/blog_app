import 'package:blog_app/domain/features/hilo/usecases/get_hilo_usecase.dart';
import 'package:blog_app/domain/features/home/usecases/get_home_portadas.dart';
import 'package:get_it/get_it.dart';

extension DependencyInjection on GetIt {
  GetIt addDomain(){
    registerSingleton(const GetHomePortadasUseCase());
    registerSingleton(const GetHiloUseCase());

    return this;
  }
}