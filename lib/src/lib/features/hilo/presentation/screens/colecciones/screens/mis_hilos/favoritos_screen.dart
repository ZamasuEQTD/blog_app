import 'package:blog_app/src/lib/features/app/presentation/extensions/scroll_controller_extensions.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/screens/colecciones/screens/mis_hilos/logic/hilos_favoritos_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HilosFavoritosScreen extends StatefulWidget {
  const HilosFavoritosScreen({super.key});

  @override
  State<HilosFavoritosScreen> createState() => _HilosFavoritosScreenState();
}

class _HilosFavoritosScreenState extends State<HilosFavoritosScreen> {
  final controller = Get.put(HilosFavoritosController());

  final scroll = ScrollController();

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
        title: const Text("Hilos favoritos"),
      ),
      body: CustomScrollView(
        controller: scroll,
        slivers: const [],
      ),
    );
  }
}
