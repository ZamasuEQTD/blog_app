import 'package:blog_app/features/colecciones/presentation/logic/controllers/hilo_por_titulo_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../hilos/domain/models/portada.dart';
import '../../../hilos/presentation/widgets/portadas/portada/delegate/portadas_delegate.dart';
import '../../../hilos/presentation/widgets/portadas/portada/portada.dart';

class HilosPorTituloScreen extends StatefulWidget {
  const HilosPorTituloScreen({super.key});

  @override
  State<HilosPorTituloScreen> createState() => _HilosPorTituloScreenState();
}

class _HilosPorTituloScreenState extends State<HilosPorTituloScreen> {
  final controller = Get.put(PortadasPorTituloController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          Obx(
            () => SliverGrid.builder(
              itemCount: controller.portadas.value.length +
                  (controller.portadasStatus.value ==
                          HomePortadasStatus.cargando
                      ? 15
                      : 0),
              gridDelegate: portadasDelegate,
              itemBuilder: (context, index) {
                if (index >= controller.portadas.value.length) {
                  return const PortadaSkeleton();
                }

                PortadaHilo portada = controller.portadas.value[index];

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
