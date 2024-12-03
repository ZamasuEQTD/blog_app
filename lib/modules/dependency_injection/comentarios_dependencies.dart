import 'package:blog_app/features/comentarios/data/dio_comentarios_repository.dart';
import 'package:blog_app/features/comentarios/domain/icomentarios_repository.dart';
import 'package:get_it/get_it.dart';

extension ComentariosDependencies on GetIt {
  GetIt addComentarios() {
    registerFactory<IComentariosRepository>(() => DioComentariosRepository());

    return this;
  }
}
