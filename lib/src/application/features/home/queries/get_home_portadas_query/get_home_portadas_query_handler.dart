import 'package:blog_app/src/application/abstractions/messaging/iquery_handler.dart';
import 'package:blog_app/src/application/features/home/queries/get_home_portadas_query/get_home_portadas_query.dart';
import 'package:blog_app/src/domain/features/hilos/ihilos_repository.dart';
import 'package:blog_app/src/domain/features/hilos/models/portada_de_hilo.dart';
import 'package:blog_app/src/domain/features/home/abstractions/ihome_repository.dart';
import 'package:blog_app/src/domain/features/home/models/portada.dart';
import 'package:blog_app/src/shared_kernel/failure.dart';
import 'package:dartz/dartz.dart';

class GetHomePortadasQueryHandler extends IQueryHandler<GetHomePortadasQuery, Either<Failure, List<PortadaHome>>> {
  final IHomeRepository _homeRepository;

  GetHomePortadasQueryHandler(this._homeRepository);

  @override
  Future<Either<Failure, List<PortadaHome>>> handle(GetHomePortadasQuery request) async {
    return _homeRepository.getPortadas(
    );
  }
}