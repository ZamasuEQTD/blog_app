import 'package:bloc/bloc.dart';
import 'package:blog_app/features/hilos/domain/usecase/get_comentarios_de_hilo_usecase.dart';
import 'package:blog_app/features/hilos/domain/usecase/get_hilo_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../../domain/models/comentario.dart';
import '../../../../domain/models/hilo.dart';

part 'hilo_event.dart';
part 'hilo_state.dart';

class HiloBloc extends Bloc<HiloEvent, HiloState> {
  final GetHiloUseCase _getHiloUseCase = GetIt.I.get();
  final GetComentariosDeHiloUsecase _getComentariosDeHiloUsecase =
      GetIt.I.get();

  final String id;
  HiloBloc(this.id) : super(const HiloState()) {
    on<RecargarHilo>(_onRecargarHilo);
    on<CargarHilo>(_onCargarHilo);
    on<EliminarHilo>(_onEliminarHilo);
    on<CargarComentarios>(_onCargarComentarios);
    on<EliminarComentario>(_onEliminarComentario);
    on<AgregarComentario>(_onAgregarComentario);
  }

  void _onRecargarHilo(RecargarHilo event, Emitter<HiloState> emit) {
    emit(const HiloState());
    add(CargarHilo());
  }

  Future _onCargarHilo(CargarHilo event, Emitter<HiloState> emit) async {
    emit(state.copyWith(status: HiloStatus.cargando));

    var result = await _getHiloUseCase.handle(GetHiloRequest(id: id));

    result.fold(
        (l) => emit(state.copyWith(status: HiloStatus.initial)),
        (r) => emit(
              state.copyWith(hilo: r, status: HiloStatus.cargado),
            ));
  }

  void _onEliminarHilo(EliminarHilo event, Emitter<HiloState> emit) {
    emit(state.copyWith(
        hilo: state.hilo!.copyWith(estado: EstadoDeHilo.eliminado)));
  }

  Future _onCargarComentarios(
      CargarComentarios event, Emitter<HiloState> emit) async {
    List<ComentarioEntry> comentarios = state.comentarios;

    emit(state.copyWith(
        comentariosStatus: ComentariosStatus.cargado,
        comentarios: [...comentarios]));

    var result = await _getComentariosDeHiloUsecase
        .handle(GetComentariosDeHiloRequest());

    result.fold(
        (l) =>
            emit(state.copyWith(comentariosStatus: ComentariosStatus.failure)),
        (r) => emit(state.copyWith(comentarios: [...comentarios, ...r])));
  }

  void _onEliminarComentario(
      EliminarComentario event, Emitter<HiloState> emit) {
    emit(state.copyWith(
        comentarios: state.comentarios
            .where((c) => c is ComentarioListEntry ? c.id != event.id : true)
            .toList()));
  }

  void _onAgregarComentario(AgregarComentario event, Emitter<HiloState> emit) {
    emit(state.copyWith(comentarios: [...state.comentarios, event.comentario]));
  }
}
