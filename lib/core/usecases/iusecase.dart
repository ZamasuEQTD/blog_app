import 'package:blog_app/core/classes/failure.dart';
import 'package:dartz/dartz.dart';

abstract class IUsecase<TRequest,TResponse> {
  const IUsecase();
  Future<Either<Failure,TResponse>> handle(TRequest request); 
}