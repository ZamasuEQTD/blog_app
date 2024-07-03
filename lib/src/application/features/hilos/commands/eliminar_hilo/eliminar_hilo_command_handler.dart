import 'package:blog_app/src/shared_kernel/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../../../domain/features/hilos/ihilos_repository.dart';
import '../../../../abstractions/messaging/icommand_handler.dart';
import 'eliminar_hilo_command.dart';

class EliminarHiloCommandHandler extends ICommandHandler<EliminarHiloCommand, Either<Failure, Unit>> {
  final IHilosRepository _hilosRepository;

  EliminarHiloCommandHandler(this._hilosRepository);
  
  @override
  Future<Either<Failure, Unit>> handle(EliminarHiloCommand command) async  {
    return _hilosRepository.eliminarHilo(hiloId: command.hiloId);
  }
  
}