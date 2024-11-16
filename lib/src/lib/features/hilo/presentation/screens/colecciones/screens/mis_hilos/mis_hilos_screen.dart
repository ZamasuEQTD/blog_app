import 'package:blog_app/src/lib/features/app/presentation/extensions/scroll_controller_extensions.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/logic/classes/coleccion_de_hilo.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/screens/colecciones/screens/mis_hilos/logic/mis_hilos_controller.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/widgets/delegates/portadas_delegate.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/widgets/portada.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MisHilosScreen extends StatefulWidget {
  const MisHilosScreen({super.key});

  @override
  State<MisHilosScreen> createState() => _MisHilosScreenState();
}

class _MisHilosScreenState extends State<MisHilosScreen> {
  final ScrollController scroll = ScrollController();

  final MisHilosController controller = Get.put(MisHilosController());

  @override
  void initState() {
    scroll.addListener(() {
      if (scroll.IsBottom) controller.cargar();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis hilos"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverGrid.builder(
            gridDelegate: portadasDelegate,
            itemCount: controller.portadas.value.length,
            itemBuilder: (context, index) => controller.portadas.value[index],
          ),
        ],
      ),
    );
  }
}

class ColeccionPortadaGrid extends StatelessWidget {
  final List<ColeccionDeHilo> portadas;

  const ColeccionPortadaGrid({super.key, required this.portadas});

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: portadas.length,
      gridDelegate: portadasDelegate,
      itemBuilder: (context, index) {
        return null;
      },
    );
  }
}
