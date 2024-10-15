import 'dart:developer';

import 'package:blog_app/common/logic/extensions/scroll_controller.dart';
import 'package:blog_app/features/home/presentation/widgets/portada/portada_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../common/logic/classes/spoileable.dart';
import '../../../../../home/domain/models/home_portada_entry.dart';
import '../../../../../media/domain/models/media.dart';
import 'logic/bloc/historial_de_hilos_bloc.dart';

class HistorialDeHilosPosteados extends StatefulWidget {
  static const SliverGridDelegate _delegate =
      SliverGridDelegateWithFixedCrossAxisCount(
    mainAxisExtent: 200,
    crossAxisSpacing: 5,
    mainAxisSpacing: 5,
    crossAxisCount: 2,
  );
  const HistorialDeHilosPosteados({super.key});

  @override
  State<HistorialDeHilosPosteados> createState() =>
      _HistorialDeHilosPosteadosState();
}

class _HistorialDeHilosPosteadosState extends State<HistorialDeHilosPosteados> {
  @override
  void initState() {
    HistorialDeHilosBloc bloc = context.read();
    ScrollController controller = context.read();

    bloc.add(CargarSiguientePagina());

    controller.addListener(() {
      if (controller.isBottom()) {
        if (bloc.state.status != HistorialDeHilosStatus.cargando) {
          bloc.add(CargarSiguientePagina());
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      sliver: BlocBuilder<HistorialDeHilosBloc, HistorialDeHilosState>(
        builder: (context, state) => SliverGrid.builder(
          gridDelegate: HistorialDeHilosPosteados._delegate,
          itemCount: state.portadas.length,
          itemBuilder: (context, index) => PortadaCard(
            portada: PortadaEntity(
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
        ),
      ),
    );
  }
}

extension ScrollControllerExtension on ScrollController {
  bool IsBottom() {
    return position.atEdge && position.pixels != 0;
  }
}
