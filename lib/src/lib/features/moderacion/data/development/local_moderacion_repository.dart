import 'package:blog_app/src/lib/features/baneos/domain/models/baneo.dart';
import 'package:blog_app/src/lib/features/baneos/presentation/screens/logic/controllers/banear_usuario.dart';
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
          provider: NetworkProvider(
            path: "https://i.blogs.es/aee3d3/gawu1m5wsaafdop/375_375.webp",
          ),
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
          provider: NetworkProvider(
            path: "https://i.blogs.es/aee3d3/gawu1m5wsaafdop/375_375.webp",
          ),
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
        ultimoBaneo: const Baneo(
          id: "good",
          moderador: "codubii",
          razon: Razon.otros,
          finaliza: null,
          mensaje: "Es un mogolico",
        ),
        registrado: DateTime.now(),
      ),
    );
  }
}
