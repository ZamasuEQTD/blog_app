import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:dartz/dartz.dart';

class GenerarMiniaturaUsecase extends IUsecase<String, String> {
  final IMiniaturaService service;

  GenerarMiniaturaUsecase(this.service);
  @override
  Future<Either<Failure, String>> handle(String request) async {
    return Right(await service.generar(request));
  }
}

abstract class IMiniaturaService {
  Future<String> generar(String video);
}
