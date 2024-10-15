import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../../../common/logic/classes/spoileable.dart';
import '../../../../../../../home/domain/models/home_portada_entry.dart';
import '../../../../../../../media/domain/models/media.dart';

part 'historial_de_hilos_event.dart';
part 'historial_de_hilos_state.dart';

class HistorialDeHilosBloc
    extends Bloc<HistorialDeHilosEvent, HistorialDeHilosState> {
  HistorialDeHilosBloc() : super(const HistorialDeHilosState()) {
    on<CargarSiguientePagina>((event, emit) async {
      emit(state.copyWith(status: HistorialDeHilosStatus.cargando));

      await Future.delayed(const Duration(seconds: 10));

      emit(
        state.copyWith(
          status: HistorialDeHilosStatus.cargados,
          portadas: [
            ...state.portadas,
            ...List.generate(
              20,
              (index) => PortadaEntity(
                imagen: Spoileable(
                  true,
                  Imagen(
                    provider: const NetworkProvider(
                      path:
                          "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696",
                    ),
                  ),
                ),
                id: "id",
                titulo: "Entras y esta tu prima asi",
                categoria: "NSFW",
                features: [
                  HomePortadaFeatures.nuevo,
                  HomePortadaFeatures.sticky,
                  HomePortadaFeatures.dados,
                  HomePortadaFeatures.idUnico,
                ],
                ultimoBump: DateTime.now(),
              ),
            ),
          ],
        ),
      );
    });
  }
}
