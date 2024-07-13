import 'package:blog_app/src/application/abstractions/messaging/iquery.dart';
import 'package:blog_app/src/domain/features/home/models/portada.dart';
import 'package:dartz/dartz.dart';

import '../../../../../shared_kernel/failure.dart';

class GetHomePortadasQuery extends IQuery<Either<Failure, List<PortadaHome>>>{
  final DateTime? utlimoBump;
  final String? titulo ;
  final String? subcategoriaId;
  GetHomePortadasQuery({
    this.utlimoBump, 
    this.titulo ,
    this.subcategoriaId
  });
}