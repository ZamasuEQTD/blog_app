import 'package:dartz/dartz.dart';

import '../../../../../domain/features/hilos/models/types/hilo_id.dart';
import '../../../../../shared_kernel/failure.dart';
import '../../../../abstractions/messaging/icommand.dart';

class EliminarHiloCommand extends ICommand<Either<Failure, Unit>> {
  final HiloId hiloId;

  const EliminarHiloCommand(this.hiloId);
}