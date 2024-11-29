import 'package:blog_app/src/lib/features/comentarios/data/development/local_comentarios_repository.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/icomentarios_repository.dart';
import 'package:get_it/get_it.dart';

import '../../features/comentarios/data/dio_comentarios_repository.dart';

extension ComentariosDependencies on GetIt {
  GetIt addComentarios() {
    registerFactory<IComentariosRepository>(() => DioComentariosRepository());

    return this;
  }
}
