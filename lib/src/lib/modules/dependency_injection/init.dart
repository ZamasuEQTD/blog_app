import 'package:blog_app/src/lib/features/app/domain/abstractions/istrategy_context.dart';
import 'package:blog_app/src/lib/features/app/domain/strategy_context.dart';
import 'package:blog_app/src/lib/modules/dependency_injection/comentarios_dependencies.dart';
import 'package:blog_app/src/lib/modules/dependency_injection/hilos_dependencies.dart';
import 'package:blog_app/src/lib/modules/dependency_injection/media_dependencies.dart';
import 'package:get_it/get_it.dart';

extension InitDependencies on GetIt {
  GetIt addDepedencies() {
    addStrategyContext().addMedia().addHilos().addComentarios();
    return this;
  }

  GetIt addStrategyContext() {
    registerFactory<IStrategyContext>(() => StrategyContext());
    return this;
  }
}
