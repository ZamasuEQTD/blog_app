import 'package:blog_app/features/hilos/data/dio_hilos.repository.dart';
import 'package:blog_app/features/hilos/domain/ihilos_repository.dart';
import 'package:get_it/get_it.dart';

extension HilosDependencies on GetIt {
  GetIt addHilos() {
    registerFactory<IHilosRepository>(() => DioHilosRepository());

    return this;
  }
}
