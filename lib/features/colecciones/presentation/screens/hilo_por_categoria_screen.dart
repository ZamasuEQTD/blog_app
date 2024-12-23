import 'package:blog_app/features/app/presentation/logic/extensions/scroll_controller_extension.dart';
import 'package:blog_app/features/colecciones/presentation/logic/controllers/hilo_por_categoria_controller.dart';
import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:blog_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../hilos/presentation/widgets/portadas/portada/delegate/portadas_delegate.dart';
import '../../../hilos/presentation/widgets/portadas/portada/portada.dart';
import '../logic/controllers/enum/portadas_status.dart';

class PortadasPorCategoriaScreen extends StatefulWidget {
  final String subcategoria;
  const PortadasPorCategoriaScreen({super.key, required this.subcategoria});

  @override
  State<PortadasPorCategoriaScreen> createState() =>
      _PortadasPorCategoriaScreenState();
}

class _PortadasPorCategoriaScreenState
    extends State<PortadasPorCategoriaScreen> {
  late final controller = Get.put(
    PortadasPorCategoriaController(subcategoriaId: widget.subcategoria),
  );

  final ScrollController scroll = ScrollController();

  @override
  void initState() {
    controller.cargarPortadas();

    if (scroll.isBottom) {
      controller.cargarPortadas();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scroll,
        slivers: [
          Obx(
            () => SliverGrid.builder(
              itemCount: controller.portadas.length +
                  (controller.portadasStatus.value == PortadasStatus.cargando
                      ? 15
                      : 0),
              gridDelegate: portadasDelegate,
              itemBuilder: (context, index) {
                if (index >= controller.portadas.length) {
                  return const PortadaSkeleton();
                }

                PortadaHilo portada = controller.portadas[index];

                return GestureDetector(
                  onTap: () => context.push("/hilo/${portada.id}"),
                  child: PortadaWidget(portada: portada),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
