import 'package:blog_app/core/classes/failure.dart';
import 'package:blog_app/core/usecases/iusecase.dart';
import 'package:blog_app/features/encuestas/domain/models/encuesta.dart';
import 'package:dartz/dartz.dart';

class VotarEncuestaUseCase extends IUsecase<VotarEncuestaRequest, Unit> {
  @override
  Future<Either<Failure, Unit>> handle(VotarEncuestaRequest request) {
    // TODO: implement handle
    throw UnimplementedError();
  }
}

class VotarEncuestaRequest {}
