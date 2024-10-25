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
  Future<Either<Failure, Hilo>> getHilo({required String id}) {
    return Future.delayed(
      const Duration(seconds: 2),
      () => Right(
        Hilo(
          id: "sfasf",
          titulo: "Cepita",
          descripcion: "Macarena",
          creadoEn: DateTime.now(),
          categoria: const SubcategoriaEntity(
            "Ma ",
            "CEPITa",
            Imagen(
              provider: NetworkProvider(
                path:
                    "https://i.pinimg.com/564x/c0/51/4a/c0514ad71f49a6f94b879b863184e621.jpg",
              ),
            ),
          ),
          portada: const Spoileable(
            true,
            Imagen(
              provider: NetworkProvider(
                path:
                    "https://i.pinimg.com/564x/c0/51/4a/c0514ad71f49a6f94b879b863184e621.jpg",
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
  Future<Either<Failure, List<HomePortada>>> getPortadas({
    DateTime? ultimoBump,
  }) {
    return Future.value(
      Right([
        HomePortada(
          id: "123",
          titulo: "Holanda",
          categoria: "CP",
          features: const [
            HomePortadaFeatures.dados,
            HomePortadaFeatures.sticky,
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
        HomePortada(
          id: "123",
          titulo: "Holanda",
          categoria: "CP",
          features: const [
            HomePortadaFeatures.dados,
            HomePortadaFeatures.sticky,
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
        HomePortada(
          id: "123",
          titulo: "Holanda",
          categoria: "CP",
          features: const [
            HomePortadaFeatures.dados,
            HomePortadaFeatures.sticky,
          ],
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
        HomePortada(
          id: "123",
          titulo: "Holanda",
          categoria: "CP",
          features: const [
            HomePortadaFeatures.dados,
            HomePortadaFeatures.sticky,
          ],
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
        HomePortada(
          id: "123",
          titulo: "Holanda",
          categoria: "CP",
          features: const [
            HomePortadaFeatures.dados,
            HomePortadaFeatures.sticky,
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
        HomePortada(
          id: "123",
          titulo: "Holanda",
          categoria: "CP",
          features: const [
            HomePortadaFeatures.dados,
            HomePortadaFeatures.sticky,
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
        HomePortada(
          id: "123",
          titulo: "Holanda",
          categoria: "CP",
          features: const [
            HomePortadaFeatures.dados,
            HomePortadaFeatures.sticky,
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
  }) {
    // TODO: implement postear
    throw UnimplementedError();
  }
}
