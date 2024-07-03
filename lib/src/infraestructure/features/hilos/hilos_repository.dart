import 'package:blog_app/src/domain/features/categorias/models/types/subcategoria_id.dart';
import 'package:blog_app/src/domain/features/hilos/ihilos_repository.dart';
import 'package:blog_app/src/domain/features/hilos/models/hilo.dart';
import 'package:blog_app/src/domain/features/hilos/models/portada_de_hilo.dart';
import 'package:blog_app/src/domain/features/hilos/models/types/hilo_id.dart';
import 'package:blog_app/src/infraestructure/features/hilos/abstractions/ihilos_datasource.dart';
import 'package:blog_app/src/shared_kernel/failure.dart';
import 'package:dartz/dartz.dart';

class HilosRepository extends IHilosRepository {
  final IHilosDatasource _datasource;

  HilosRepository(this._datasource);
  @override
  Future<Either<Failure, Unit>> cambiarCategoriaHilo({required HiloId hiloId, required SubcategoriaId subcategoriaId}) {
    // TODO: implement cambiarCategoriaHilo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, HiloId>> crearHilo({required String titulo, required String descripcion, required SubcategoriaId subcategoriaId, required List<String>? encuesta}) {
    // TODO: implement crearHilo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> eliminarHilo({required HiloId hiloId}) {
    // TODO: implement eliminarHilo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Hilo>> getHilo({required HiloId hiloId}) {
    return _datasource.getHilo(id: hiloId);
  }

  @override
  Future<Either<Failure, List<PortadaDeHilo>>> getPortadasDeHilosHome({DateTime? utlimoBump, String? titulo, SubcategoriaId? subcategoriaId}) {
    // TODO: implement getPortadasDeHilosHome
    throw UnimplementedError();
  }
}