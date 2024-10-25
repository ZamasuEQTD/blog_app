import 'package:blog_app/src/lib/features/hilo/data/development/local_hilos_repository.dart';
import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:get_it/get_it.dart';

extension HilosDependencies on GetIt {
  GetIt addHilos() {
    registerFactory<IHilosRepository>(
      () => LocalHilosRepository(),
    );
    return this;
  }
}
