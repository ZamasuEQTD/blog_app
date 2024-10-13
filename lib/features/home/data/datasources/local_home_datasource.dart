import 'package:blog_app/common/logic/classes/spoileable.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/classes/failure.dart';
import '../../domain/abstractions/ihome_repository.dart';
import '../../domain/models/home_portada_entry.dart';
import '../abstractions/ihome_datasource.dart';

class LocalHomeDatasource extends IHomeDatasource {
  @override
  Future<Either<Failure, List<PortadaEntity>>> getPortadas(
    GetHomePortadasRequest request,
  ) async {
    await Future.delayed(const Duration(seconds: 3));
    return Right([
      PortadaEntity(
        imagen: Spoileable(
          true,
          Imagen(
            provider: const NetworkProvider(
              path:
                  "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696",
            ),
          ),
        ),
        id: "id",
        titulo: "Entras y esta tu prima asi",
        categoria: "NSFW",
        features: [
          HomePortadaFeatures.nuevo,
          HomePortadaFeatures.sticky,
          HomePortadaFeatures.dados,
          HomePortadaFeatures.idUnico,
        ],
        ultimoBump: DateTime.now(),
      ),
    ]);
  }
}
