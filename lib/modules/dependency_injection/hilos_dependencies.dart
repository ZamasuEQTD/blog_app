import 'package:blog_app/features/hilos/data/dio_hilos.repository.dart';
import 'package:blog_app/features/hilos/domain/ihilos_repository.dart';
import 'package:blog_app/features/home/data/signalr_home_hub.dart';
import 'package:blog_app/features/home/domain/hub/ihome_portadas_hub.dart';
import 'package:get_it/get_it.dart';

extension HilosDependencies on GetIt {
  GetIt addHilos() {
    registerFactory<IHilosRepository>(() => DioHilosRepository());
    registerFactory<IPortadasHub>(() => SignalrHomeHub());

    return this;
  }
}
