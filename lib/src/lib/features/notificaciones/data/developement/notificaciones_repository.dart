import 'package:blog_app/src/lib/features/media/domain/models/media.dart';
import 'package:blog_app/src/lib/features/notificaciones/domain/inotificaciones_repository.dart';
import 'package:blog_app/src/lib/features/notificaciones/domain/models/notificacion.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:dartz/dartz.dart';

class LocalNotificacionesRepository extends INotificacionesRepository {
  @override
  Future<Either<Failure, List<Notificacion>>> getMisNotificaciones() async {
    return const Right([
      HiloComentado(
        id: "pepe",
        hiloId: "1",
        portada: Imagen(
          provider: NetworkProvider(
            path:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQVV-gF_aPDtaOzgILewOSOq-hIHJNbuQLNg&s",
          ),
        ),
        titulo: "Cepita gratis",
        descripcion: "Pepitooooo",
      ),
      ComentarioRespondido(
        id: "fa",
        hiloId: "1",
        titulo: "Cepita gratis",
        comentario: "Hola",
        portada: Imagen(
          provider: NetworkProvider(
            path:
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQVV-gF_aPDtaOzgILewOSOq-hIHJNbuQLNg&s",
          ),
        ),
      ),
    ]);
  }

  @override
  Future<Either<Failure, Unit>> leerNotificacion({
    required NotificacionId id,
  }) async {
    return const Right(unit);
  }

  @override
  Future<Either<Failure, Unit>> leerTodas() async {
    return const Right(unit);
  }
}
