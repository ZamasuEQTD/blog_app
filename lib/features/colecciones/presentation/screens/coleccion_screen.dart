// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/features/app/presentation/logic/extensions/scroll_controller_extension.dart';
import 'package:blog_app/features/hilos/presentation/widgets/portadas/portada/portada.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../hilos/domain/models/portada.dart';
import '../logic/controllers/coleccion_controller.dart';

class ColeccionScreen extends StatefulWidget {
  final Coleccion coleccion;
  const ColeccionScreen({
    super.key,
    required this.coleccion,
  });

  @override
  State<ColeccionScreen> createState() => _ColeccionScreenState();
}

class _ColeccionScreenState extends State<ColeccionScreen> {
  late final controller =
      Get.put(ColeccionController(coleccion: widget.coleccion));

  final ScrollController scroll = ScrollController();

  @override
  void initState() {
    scroll.addListener(() {
      if (scroll.isBottom) {
        controller.cargar();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    Get.delete<ColeccionController>();
    scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hilos ${widget.coleccion.name}"),
      ),
      body: CustomScrollView(
        controller: scroll,
        slivers: [
          Obx(
            () => SliverList.builder(
              itemCount: controller.hilos.length,
              itemBuilder: (context, index) {
                if (index > controller.hilos.length) {
                  return const PortadaSkeleton();
                }

                PortadaHilo portada = controller.hilos[index];

                return GestureDetector(
                  onTap: () => context.go("hilos/${portada.id}"),
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
