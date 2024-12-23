import 'package:blog_app/features/app/presentation/logic/extensions/scroll_controller_extension.dart';
import 'package:blog_app/features/colecciones/presentation/logic/controllers/enum/portadas_status.dart';
import 'package:blog_app/features/colecciones/presentation/logic/controllers/hilo_por_titulo_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../hilos/domain/models/portada.dart';
import '../../../hilos/presentation/widgets/portadas/portada/delegate/portadas_delegate.dart';
import '../../../hilos/presentation/widgets/portadas/portada/portada.dart';

class PortadasPorTituloScreen extends StatefulWidget {
  const PortadasPorTituloScreen({super.key});

  @override
  State<PortadasPorTituloScreen> createState() =>
      _PortadasPorTituloScreenState();
}

class _PortadasPorTituloScreenState extends State<PortadasPorTituloScreen> {
  final controller = Get.put(PortadasPorTituloController());

  final ScrollController scroll = ScrollController();

  @override
  void initState() {
    if (scroll.isBottom) {
      controller.cargarPortadas();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          Flexible(
            child: TextField(
              onChanged: (value) => controller.titulo.value = value,
              decoration: InputDecoration(
                hintText: "Titulo de hilo...",
                icon: IconButton(
                  onPressed: () => controller.cargarPortadas(),
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
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
