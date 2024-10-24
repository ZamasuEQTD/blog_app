import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blog_app/src/lib/features/notificaciones/domain/inotificaciones_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../../domain/models/notificacion.dart';

part 'notificaciones_event.dart';
part 'notificaciones_state.dart';

class NotificacionesBloc
    extends Bloc<NotificacionesEvent, NotificacionesState> {
  final INotificacionesRepository _repository = GetIt.I.get();
  NotificacionesBloc() : super(const NotificacionesState()) {
    on<CargarNotificaciones>(_onCargarNotificaciones);
  }

  FutureOr<void> _onCargarNotificaciones(
    CargarNotificaciones event,
    Emitter<NotificacionesState> emit,
  ) async {
    var result = await _repository.getMisNotificaciones();

    result.fold(
      (l) => emit(
        state.copyWith(),
      ),
      (r) => emit(
        state.copyWith(
          status: NotificacionesStatus.cargadas,
          notificaciones: [
            ...r,
            ...state.notificaciones,
          ],
        ),
      ),
    );
  }
}
