import 'package:blog_app/src/application/features/comentarios/queries/get_comentarios/get_comentarios_query_handler.dart';
import 'package:blog_app/src/application/features/hilos/queries/get_hilo/get_hilo_query_handler.dart';
import 'package:blog_app/src/application/features/home/queries/get_home_portadas_query/get_home_portadas_query_handler.dart';
import 'package:get_it/get_it.dart';

extension ApplicationDependency on GetIt {
  GetIt addApplication(){
    _addHilos();

    return this;
  }

  GetIt _addHilos(){
    registerLazySingleton(() => GetComentariosQueryHandler(get()));
    registerLazySingleton(() => GetHiloQueryHandler( get()));
    registerLazySingleton(() => GetHomePortadasQueryHandler(get()));
    return this;
  }
}