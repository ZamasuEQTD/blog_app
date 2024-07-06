import 'package:blog_app/src/domain/features/comentarios/abstractions/icomentarios_repository.dart';
import 'package:blog_app/src/infraestructure/features/comentarios/abstractions/icomentarios_datasource.dart';
import 'package:blog_app/src/infraestructure/features/comentarios/comentarios_repository.dart';
import 'package:blog_app/src/infraestructure/features/comentarios/datasources/local_comentarios_datasource.dart';
import 'package:blog_app/src/infraestructure/features/hilos/abstractions/ihilos_datasource.dart';
import 'package:blog_app/src/infraestructure/features/hilos/datasources/local_datasource.dart';
import 'package:blog_app/src/infraestructure/features/hilos/hilos_repository.dart';
import 'package:blog_app/src/presentation/features/hilos/views/ver_hilo/widgets/comentarios/comentarios_de_hilo.dart';
import 'package:get_it/get_it.dart';

import '../../domain/features/hilos/ihilos_repository.dart';

extension InfraestructureDependencies on GetIt {
  GetIt addInfraestructure() {
    registerLazySingleton<IHilosDatasource>(() => HilosLocalDatasource());
    registerLazySingleton<IHilosRepository>(() => HilosRepository(get()));
    registerLazySingleton<IComentariosDatasource>(() => ComentariosLocalDatasource());
    registerLazySingleton<IComentariosRepository>(() => ComentariosRepository(get()));
    return this;
  }
}