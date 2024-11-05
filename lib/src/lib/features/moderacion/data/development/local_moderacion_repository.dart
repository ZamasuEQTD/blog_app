import 'package:blog_app/src/lib/features/media/domain/models/media.dart';
import 'package:blog_app/src/lib/features/moderacion/domain/imoderacion_repository.dart';
import 'package:blog_app/src/lib/features/moderacion/domain/models/registro_de_comentario.dart';
import 'package:blog_app/src/lib/features/moderacion/domain/models/registro_de_hilo.dart';
import 'package:blog_app/src/lib/features/moderacion/domain/models/usuario.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:dartz/dartz.dart';

class LocalModeracionRepository extends IModeracionRepository {
  @override
  Future<Either<Failure, List<ComentarioHistorial>>> getComentarioHistorials({
    required String usuario,
    DateTime? ultimo,
  }) async {
    return Right([
      ComentarioHistorial(
        id: "1",
        hilo: "1",
        portada: const Imagen(
          provider: NetworkProvider(path: "https://via.placeholder.com/150"),
        ),
        titulo: "Pedro",
        texto: "Comentario 1",
        registro: DateTime.now(),
      ),
    ]);
  }

  @override
  Future<Either<Failure, List<HiloHistorial>>> getHistorialHilos({
    required String usuario,
    DateTime? ultimo,
  }) async {
    return Right([
      HiloHistorial(
        hilo: "1",
        portada: const Imagen(
          provider: NetworkProvider(path: "https://via.placeholder.com/150"),
        ),
        descripcion: "1",
        titulo: "Pedro",
        registro: DateTime.now(),
      ),
    ]);
  }

  @override
  Future<Either<Failure, Usuario>> verUsuario({required String usuario}) async {
    return Right(
      Usuario(
        id: "1",
        nombre: "Pedro",
        registrado: DateTime.now(),
      ),
    );
  }
}
