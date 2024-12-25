import 'package:blog_app/features/baneos/data/dio_baneos_repository.dart';
import 'package:blog_app/features/baneos/domain/ibaneos_repository.dart';
import 'package:get_it/get_it.dart';

extension BaneosDependencies on GetIt {
  GetIt addBaneos() {
    registerLazySingleton<IBaneosRepository>(
      () => DioBaneosRepository(),
    );
    return this;
  }
}
