import 'package:blog_app/src/infraestructure/features/hilos/abstractions/ihilos_datasource.dart';
import 'package:blog_app/src/infraestructure/features/hilos/datasources/local_datasource.dart';
import 'package:blog_app/src/infraestructure/features/hilos/hilos_repository.dart';
import 'package:get_it/get_it.dart';

import '../../domain/features/hilos/ihilos_repository.dart';

extension InfraestructureDependencies on GetIt {
  GetIt addInfraestructure() {
    registerLazySingleton<IHilosDatasource>(() => HilosLocalDatasource());
    registerLazySingleton<IHilosRepository>(() => HilosRepository(get()));
    return this;
  }
}