import 'package:blog_app/src/lib/features/app/presentation/extensions/scroll_controller_extensions.dart';
import 'package:blog_app/src/lib/features/home/data/development/home_local_hub.dart';
import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:blog_app/src/lib/features/home/domain/hub/ihome_portadas_hub.dart';
import 'package:blog_app/src/lib/features/home/presentation/screens/logic/blocs/home/home_bloc.dart';
import 'package:blog_app/src/lib/features/home/presentation/screens/logic/home_controller.dart';
import 'package:blog_app/src/lib/features/home/presentation/screens/widgets/portada.dart';
import 'package:blog_app/src/lib/features/notificaciones/presentation/logic/controles/mis_notificaciones_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../app/presentation/widgets/colored_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late IHomePortadasHub hub = HomeLocalHub();
  HomeController controller = Get.put(HomeController()..cargarPortadas());
  final ScrollController scroll = ScrollController();
  @override
  void initState() {
    scroll.addListener(
      () {
        if (scroll.IsBottom) controller.cargarPortadas();
      },
    );

    hub.onHiloCreado(
      (portada) {
        controller.agregarPortada(portada);
      },
    );

    hub.onHiloEliminado((id) => controller.eliminar(id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        controller: scroll,
        slivers: const [
          _HomePortadasFiltros(),
          _HomePortadasGrid(),
        ],
      ),
      floatingActionButton: ColoredIconButton(
        border: BorderRadius.circular(10),
        background: const Color(0xffF5F5F5),
        onPressed: () => context.push("/postear-hilo"),
        icon: const Icon(
          Icons.abc,
          size: 30,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _HomePortadasFiltros extends StatelessWidget {
  const _HomePortadasFiltros({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _FiltrarPortadasPorTitulo(),
            const SizedBox(
              width: 10,
            ),
            ColoredIconButton(
              background: const Color(0xffF5F5F5),
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.box),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomePortadasGrid extends StatelessWidget {
  static const SliverGridDelegate _delegate =
      SliverGridDelegateWithFixedCrossAxisCount(
    mainAxisExtent: 200,
    crossAxisSpacing: 5,
    mainAxisSpacing: 5,
    crossAxisCount: 2,
  );

  const _HomePortadasGrid({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      sliver: Obx(
        () {
          return SliverGrid.builder(
            itemCount: controller.portadas.value.length,
            gridDelegate: _delegate,
            itemBuilder: (context, index) {
              if (index >= controller.portadas.value.length) {
                return const Skeletonizer.zone(child: Portada.bone());
              }

              HomePortada entry = controller.portadas.value[index];

              return GestureDetector(
                onTap: () => context.push("/hilo/${entry.id}"),
                // onLongPress: () => OpcionesDePortadaBottomSheet.show(context),
                child: Portada.portada(
                  portada: entry,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _FiltrarPortadasPorTitulo extends StatelessWidget {
  const _FiltrarPortadasPorTitulo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Flexible(
      child: TextField(
        maxLines: 1,
        onChanged: (value) {
          controller.titulo.value = value;
        },
        decoration: InputDecoration(
          hintText: "Buscar por titulo",
          suffixIcon: IconButton(
            onPressed: () => controller.filtrar,
            icon: const Icon(Icons.search_outlined),
          ),
        ),
      ),
    );
  }
}
