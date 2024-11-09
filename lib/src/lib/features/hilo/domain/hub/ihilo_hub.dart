import 'package:blog_app/src/lib/features/comentarios/domain/models/comentario.dart';
import 'package:blog_app/src/lib/features/comentarios/domain/models/typedef.dart';
import 'package:blog_app/src/lib/features/hilo/domain/models/types.dart';

abstract class IHiloHub {
  Stream<Comentario> get onComentarioPosteado;
  Stream<ComentarioId> get onComentarioEliminado;

  void connect(HiloId id);
  void dispose();
}
