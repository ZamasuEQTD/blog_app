import 'package:bloc/bloc.dart';
import 'package:blog_app/features/media/domain/models/media.dart';
import 'package:equatable/equatable.dart';

part 'historial_de_comentarios_event.dart';
part 'historial_de_comentarios_state.dart';

class HistorialDeComentariosBloc
    extends Bloc<HistorialDeComentariosEvent, HistorialDeComentariosState> {
  HistorialDeComentariosBloc() : super(const HistorialDeComentariosState()) {
    on<CargarSiguientePagina>((event, emit) async {
      emit(
        state.copyWith(
          status: HistorialDeComentariosStatus.cargando,
        ),
      );

      await Future.delayed(const Duration(seconds: 5));

      emit(
        state.copyWith(
          status: HistorialDeComentariosStatus.cargados,
          comentarios: [
            ...state.comentarios,
            ...List.generate(
              20,
              (index) => HistorialDeComentarioItem(
                id: "ss",
                hilo: HistorialDeComentarioHilo(
                  id: "",
                  titulo: "Aguante la b2filia",
                  portada: Imagen(
                    provider: const NetworkProvider(
                      path: "https://i.redd.it/eopud74baswa1.png",
                    ),
                  ),
                ),
                comentario:
                    "pepitooopepitooopepitooopepitooopepitooopepitooopepitooopepitooo",
              ),
            ),
          ],
        ),
      );
    });
  }
}
