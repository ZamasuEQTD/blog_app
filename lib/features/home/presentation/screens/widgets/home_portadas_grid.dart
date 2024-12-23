import 'package:blog_app/features/hilos/domain/models/portada.dart';
import 'package:blog_app/features/hilos/presentation/screens/hilo_screen/widgets/opciones_de_hilo.dart';
import 'package:blog_app/features/hilos/presentation/widgets/portadas/portada/delegate/portadas_delegate.dart';
import 'package:blog_app/features/hilos/presentation/widgets/portadas/portada/portada.dart';
import 'package:blog_app/features/home/presentation/logic/home_controller.dart';
import 'package:blog_app/features/media/presentation/logic/extension/media_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class HomePortadasGrid extends StatelessWidget {
  const HomePortadasGrid({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Obx(
      () => SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        sliver: SliverMainAxisGroup(
          slivers: [
            if (controller.subcategoria.value != null)
              SubcategoriaSeleccionadaHome(controller: controller),
            SliverGrid.builder(
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
                  onLongPress: () => showMaterialModalBottomSheet(
                    context: context,
                    builder: (context) => HiloOpciones(portada: portada),
                  ),
                  onTap: () => context.push("/hilo/${portada.id}"),
                  child: PortadaWidget(portada: portada),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SubcategoriaSeleccionadaHome extends StatelessWidget {
  final HomeController controller;

  const SubcategoriaSeleccionadaHome({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ColoredBox(
          color: Theme.of(context).colorScheme.onSurface,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SizedBox.square(
                      dimension: 30,
                      child: Image(
                        image: controller.subcategoria.value!.imagen.toProvider,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      controller.subcategoria.value!.nombre,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => controller.subcategoria.value = null,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
        ),
      ).marginOnly(bottom: 10),
    );
  }
}
