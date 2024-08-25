import 'package:dartz/dartz.dart';

import '../classes/failure.dart';

abstract class IUsecase<TRequest, TResponse> {
  const IUsecase();
  Future<Either<Failure, TResponse>> handle(TRequest request);
}
