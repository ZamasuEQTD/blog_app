import 'package:dartz/dartz.dart';

import '../../../shared_kernel/failure.dart';
import '../categorias/models/types/subcategoria_id.dart';
import 'models/hilo.dart';
import 'models/portada_de_hilo.dart';
import 'models/types/hilo_id.dart';

abstract class IHilosRepository {
  Future<Either<Failure,List<PortadaDeHilo>>> getPortadasDeHilosHome({
    DateTime? utlimoBump,
    String? titulo,
    SubcategoriaId? subcategoriaId
  });

  Future<Either<Failure,Unit>> eliminarHilo({
    required HiloId hiloId
  });

  Future<Either<Failure,Unit>> cambiarCategoriaHilo({
    required HiloId hiloId,
    required SubcategoriaId subcategoriaId
  });


  Future<Either<Failure, Hilo>> getHilo(
      {required HiloId hiloId}
    );
  Future<Either<Failure,HiloId>> crearHilo({
    required String titulo,
    required String descripcion,
    required SubcategoriaId subcategoriaId,
    required List<String>? encuesta
  });
} 
