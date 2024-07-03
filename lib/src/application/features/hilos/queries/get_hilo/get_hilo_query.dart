import 'package:dartz/dartz.dart';

import '../../../../../domain/features/hilos/models/hilo.dart';
import '../../../../../domain/features/hilos/models/types/hilo_id.dart';
import '../../../../../shared_kernel/failure.dart';
import '../../../../abstractions/messaging/iquery.dart';


class GetHiloQuery extends IQuery<Either<Failure,Hilo>>{
  final HiloId id;

  GetHiloQuery(this.id);
}