import 'package:blog_app/domain/features/comentarios/entities/comentario.dart';

abstract class IHiloHub {
  void onEliminado(void Function() onEliminado);
  void onComentado(void Function(Comentario comentario) onComentado);
  void onComentarioEliminado(void Function(ComentarioId id) onComentarioEliminado); 
}