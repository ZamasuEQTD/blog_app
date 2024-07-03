import 'package:blog_app/src/domain/features/hilos/models/hilo.dart';
import 'package:blog_app/src/shared_kernel/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IHilosDatasource {
  Future<Either<Failure,Hilo>> getHilo({
    required String id
  });
}
