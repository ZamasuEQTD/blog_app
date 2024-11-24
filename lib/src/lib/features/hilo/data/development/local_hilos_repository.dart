import 'package:blog_app/src/lib/features/app/domain/models/spoileable.dart';
import 'package:blog_app/src/lib/features/categorias/domain/models/subcategoria.dart';
import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:blog_app/src/lib/features/hilo/domain/models/hilo.dart';
import 'package:blog_app/src/lib/features/hilo/domain/models/types.dart';
import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:blog_app/src/lib/features/media/domain/models/media.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:dartz/dartz.dart';

class LocalHilosRepository extends IHilosRepository {
  @override
  Future<Either<Failure, Hilo>> getHilo({required String id}) async {
    return await Future.delayed(
      const Duration(seconds: 1),
      () => Right(
        Hilo(
          id: "sfasf",
          titulo: "Cepita",
          descripcion: "Macarena",
          creadoEn: DateTime.now(),
          categoria: const Subcategoria(
            id: "123",
            nombre: "CEPITa",
            imagen: Imagen(
              provider: NetworkProvider(
                path:
                    "https://freeadultcomix.com/wp-content/uploads/2022/11/Shadbase-One-Shot-Comics-6.jpg",
              ),
            ),
          ),
          portada: const Spoileable(
            true,
            Imagen(
              provider: NetworkProvider(
                path:
                    "https://es.gizmodo.com/app/uploads/2023/10/ce488f6891156e5ef7a395f5b590eeb1.jpg",
              ),
            ),
          ),
          estado: EstadoDeHilo.activo,
          banderas: [
            BanderasDeHilo.dados,
            BanderasDeHilo.idUnico,
            BanderasDeHilo.sticky,
          ],
          comentarios: 300,
          esOp: false,
        ),
      ),
    );
  }

  @override
  Future<Either<Failure, List<Portada>>> getPortadas({
    String? titulo,
    SubcategoriaId? subcategoria,
    DateTime? ultimoBump,
  }) {
    return Future.delayed(
      const Duration(seconds: 5),
      () => Right([
        Portada(
          id: "123",
          titulo: "Holanda",
          categoria: "CP",
          features: const [
            PortadaFeatures.dados,
            PortadaFeatures.sticky,
          ],
          esOp: true,
          ultimoBump: DateTime.now(),
          imagen: const Spoileable(
            false,
            Imagen(
              provider: NetworkProvider(
                path:
                    "https://i.pinimg.com/564x/c0/51/4a/c0514ad71f49a6f94b879b863184e621.jpg",
              ),
            ),
          ),
        ),
        Portada(
          id: "123",
          titulo: "Holanda",
          categoria: "CP",
          esOp: true,
          features: const [
            PortadaFeatures.dados,
            PortadaFeatures.sticky,
          ],
          ultimoBump: DateTime.now(),
          imagen: const Spoileable(
            false,
            Imagen(
              provider: NetworkProvider(
                path:
                    "https://i.pinimg.com/564x/c0/51/4a/c0514ad71f49a6f94b879b863184e621.jpg",
              ),
            ),
          ),
        ),
        Portada(
          id: "123",
          titulo: "Holanda",
          categoria: "CP",
          features: const [
            PortadaFeatures.dados,
            PortadaFeatures.sticky,
          ],
          esOp: true,
          ultimoBump: DateTime.now(),
          imagen: const Spoileable(
            true,
            Imagen(
              provider: NetworkProvider(
                path:
                    "https://i.pinimg.com/564x/c0/51/4a/c0514ad71f49a6f94b879b863184e621.jpg",
              ),
            ),
          ),
        ),
        Portada(
          id: "123",
          titulo: "Holanda",
          categoria: "CP",
          features: const [
            PortadaFeatures.dados,
            PortadaFeatures.sticky,
          ],
          esOp: true,
          ultimoBump: DateTime.now(),
          imagen: const Spoileable(
            true,
            Imagen(
              provider: NetworkProvider(
                path:
                    "https://i.pinimg.com/564x/c0/51/4a/c0514ad71f49a6f94b879b863184e621.jpg",
              ),
            ),
          ),
        ),
        Portada(
          id: "123",
          titulo: "Holanda",
          categoria: "CP",
          features: const [
            PortadaFeatures.dados,
            PortadaFeatures.sticky,
          ],
          esOp: true,
          ultimoBump: DateTime.now(),
          imagen: const Spoileable(
            false,
            Imagen(
              provider: NetworkProvider(
                path:
                    "https://i.pinimg.com/564x/c0/51/4a/c0514ad71f49a6f94b879b863184e621.jpg",
              ),
            ),
          ),
        ),
        Portada(
          id: "123",
          titulo: "Holanda",
          categoria: "CP",
          features: const [
            PortadaFeatures.dados,
            PortadaFeatures.sticky,
          ],
          esOp: true,
          ultimoBump: DateTime.now(),
          imagen: const Spoileable(
            false,
            Imagen(
              provider: NetworkProvider(
                path:
                    "https://i.pinimg.com/564x/c0/51/4a/c0514ad71f49a6f94b879b863184e621.jpg",
              ),
            ),
          ),
        ),
        Portada(
          id: "123",
          titulo: "Holanda",
          categoria: "CP",
          esOp: true,
          features: const [
            PortadaFeatures.dados,
            PortadaFeatures.sticky,
          ],
          ultimoBump: DateTime.now(),
          imagen: const Spoileable(
            false,
            Imagen(
              provider: NetworkProvider(
                path:
                    "https://i.pinimg.com/564x/c0/51/4a/c0514ad71f49a6f94b879b863184e621.jpg",
              ),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  Future<Either<Failure, HiloId>> postear({
    required String titulo,
    required String descripcion,
    required Spoileable<Media> portada,
    required List<String> encuesta,
    required SubcategoriaId subcategoria,
    required bool dados,
    required bool idUnico,
  }) async {
    return const Right("123");
  }

  @override
  Future<Either<Failure, Unit>> eliminar({required String id}) {
    // TODO: implement eliminar
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> ocultar({required String id}) {
    // TODO: implement ocultar
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> ponerEnFavoritos({required String id}) {
    // TODO: implement ponerEnFavoritos
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> seguir({required String id}) {
    // TODO: implement seguir
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> desactivarNotificaciones({required String id}) {
    // TODO: implement desactivarNotificaciones
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> establecerSticky({required String id}) {
    throw UnimplementedError();
  }
}
