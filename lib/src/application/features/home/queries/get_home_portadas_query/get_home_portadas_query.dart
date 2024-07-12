import 'package:blog_app/src/application/abstractions/messaging/iquery.dart';
import 'package:blog_app/src/domain/features/hilos/models/portada_de_hilo.dart';
import 'package:dartz/dartz.dart';

import '../../../../../shared_kernel/failure.dart';

class GetHomePortadasQuery extends IQuery<Either<Failure, List<PortadaDeHilo>>>{
  final DateTime? utlimoBump;
  final String? titulo ;
  final String? subcategoriaId;
  GetHomePortadasQuery({
    this.utlimoBump, 
    this.titulo ,
    this.subcategoriaId
  });
}