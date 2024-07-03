import 'package:dartz/dartz.dart';
import '../../../../../domain/features/hilos/ihilos_repository.dart';
import '../../../../../domain/features/hilos/models/hilo.dart';
import '../../../../../shared_kernel/failure.dart';
import '../../../../abstractions/messaging/iquery_handler.dart';
import 'get_hilo_query.dart';

class GetHiloQueryHandler extends IQueryHandler<GetHiloQuery, Either<Failure,Hilo>> {
  final IHilosRepository _hiloRepository;

  GetHiloQueryHandler(this._hiloRepository);
  @override
  Future<Either<Failure, Hilo>> handle(GetHiloQuery request) {
    return _hiloRepository.getHilo(
      hiloId: request.id
    );    
  }
}