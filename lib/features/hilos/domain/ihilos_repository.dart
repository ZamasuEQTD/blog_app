import 'package:blog_app/features/app/clases/failure.dart';
import 'package:blog_app/features/app/domain/models/spoileable.dart';
import 'package:blog_app/features/categorias/domain/models/categoria.dart';
import 'package:blog_app/features/hilos/domain/models/hilo.dart';
import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:blog_app/features/hilos/domain/models/types.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:dartz/dartz.dart';

import '../presentation/widgets/denunciar_hilo/denunciar_hilo.dart';

abstract class IHilosRepository {
  Future<Either<Failure, HiloId>> postear({
    required String titulo,
    required String descripcion,
    required Spoileable<Media> portada,
    required SubcategoriaId subcategoria,
    required List<String> encuesta,
    required bool dados,
    required bool idUnico,
  });

  Future<Either<Failure, Hilo>> getHilo({
    required String id,
  });

  Future<Either<Failure, List<PortadaHilo>>> getPortadas({
    String? titulo,
    SubcategoriaId? subcategoria,
    HiloId? ultimo,
  });

  Future<Either<Failure, Unit>> eliminar({
    required String id,
  });

  Future<Either<Failure, Unit>> seguir({
    required String id,
  });

  Future<Either<Failure, Unit>> ponerEnFavoritos({
    required String id,
  });

  Future<Either<Failure, Unit>> ocultar({
    required String id,
  });

  Future<Either<Failure, Unit>> cambiarNotificaciones({
    required String id,
  });

  Future<Either<Failure, Unit>> establecerSticky({
    required String id,
  });

  Future<Either<Failure, Unit>> eliminarSticky({
    required String id,
  });

  Future<Either<Failure, Unit>> cambiarSubcategoria({
    required String id,
    required SubcategoriaId nuevaSubcategoria,
  });

  Future<Either<Failure, Unit>> denunciar({
    required String id,
    required HiloRazonDenuncia denuncia,
  });
}
