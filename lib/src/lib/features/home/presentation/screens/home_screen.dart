import 'package:blog_app/src/lib/features/app/presentation/extensions/scroll_controller_extensions.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/item_seleccionable.dart';
import 'package:blog_app/src/lib/features/auth/presentation/logic/controlls/auth_controller.dart';
import 'package:blog_app/src/lib/features/auth/presentation/widgets/sesion_requerida.dart';
import 'package:blog_app/src/lib/features/categorias/presentation/seleccionar_subcategoria_bottom_sheet.dart';
import 'package:blog_app/src/lib/features/home/data/development/home_local_hub.dart';
import 'package:blog_app/src/lib/features/home/domain/hub/ihome_portadas_hub.dart';
import 'package:blog_app/src/lib/features/home/presentation/screens/logic/home_controller.dart';
import 'package:blog_app/src/lib/features/home/presentation/screens/widgets/portada_home.dart';
import 'package:blog_app/src/lib/features/media/presentation/extensions/media_extensions.dart';
import 'package:blog_app/src/lib/modules/routing.dart';
import 'package:blog_app/src/lib/utils/clases/failure.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../../app/presentation/widgets/colored_icon_button.dart';
import '../../../hilo/presentation/widgets/delegates/portadas_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late IPortadasHub hub = HomeLocalHub();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  HomeController controller = Get.put(HomeController())..cargarPortadas();

  final ScrollController scroll = ScrollController();

  @override
  void initState() {
    scroll.addListener(
      () {
        if (scroll.IsBottom) controller.cargarPortadas();
      },
    );

    controller.subcategoria.listen((subcategoria) {
      if (subcategoria != null) {
        controller.cargarPortadas();
      }
    });

    controller.failure.listen((l) {
      if (l is Failure) {}
    });

    hub.connect();

    hub.onHiloPosteado.listen(
      (portada) => controller.agregarPortada(PortadaHome(portada: portada)),
    );

    hub.onHiloEliminado.listen((id) => controller.eliminar(id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      endDrawer: const HomeMenu(),
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () => context.push(Routes.notificaciones),
            icon: const Icon(
              Icons.notifications,
            ),
            label: const Text("991+"),
          ),
          IconButton(
            onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
            icon: const FaIcon(FontAwesomeIcons.bars),
          ),
        ],
      ),
      body: CustomScrollView(
        controller: scroll,
        slivers: const [
          _PortadasFiltros(),
          _PortadasGrid(),
        ],
      ),
      floatingActionButton: ColoredIconButton(
        border: BorderRadius.circular(10),
        background: Colors.white,
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

class _PortadasFiltros extends StatelessWidget {
  const _PortadasFiltros({super.key});

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
              onPressed: () => SeleccionarSubcategoriaBottomSheet.show(
                context,
                onSubcategoriaSeleccionada: (subcategoria) =>
                    Get.find<HomeController>().subcategoria.value =
                        subcategoria,
              ),
              icon: const FaIcon(FontAwesomeIcons.box),
            ),
          ],
        ),
      ),
    );
  }
}

class _PortadasGrid extends StatelessWidget {
  const _PortadasGrid({super.key});

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
              itemCount: controller.portadas.value.length,
              gridDelegate: portadasDelegate,
              itemBuilder: (context, index) => controller.portadas.value[index],
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

class _FiltrarPortadasPorTitulo extends StatefulWidget {
  const _FiltrarPortadasPorTitulo({
    super.key,
  });

  @override
  State<_FiltrarPortadasPorTitulo> createState() =>
      _FiltrarPortadasPorTituloState();
}

class _FiltrarPortadasPorTituloState extends State<_FiltrarPortadasPorTitulo> {
  final TextEditingController titulo = TextEditingController();

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();
    return Flexible(
      child: TextField(
        controller: titulo,
        decoration: InputDecoration(
          hintText: "Buscar por titulo",
          suffixIcon: IconButton(
            onPressed: () => controller.titulo.value = titulo.text,
            icon: const Icon(
              Icons.search_outlined,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Obx(() {
          if (Get.find<AuthController>().usuario.value == null) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(Routes.login);
                      },
                      child: const Text("Iniciar Sesión"),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(Routes.registro);
                      },
                      child: const Text("Registrarse"),
                    ).withSecondaryStyle(context),
                  ),
                ],
              ),
            ).paddingSymmetric(horizontal: 20);
          }
          return Column(
            children: [
              Text(
                "Bienvenido, ${Get.find<AuthController>().usuario.value!.usuario}",
                style: context.textTheme.titleMedium,
              ),
              ItemSeleccionable.text(
                onTap: () => context.push(Routes.misHilos),
                titulo: "Mis hilos",
              ),
              const ItemSeleccionable.text(
                titulo: "Hilos favoritos",
              ),
              const ItemSeleccionable.text(
                titulo: "Palabras bloqueadas",
              ),
              ItemSeleccionable.text(
                titulo: "Cerrar sesion",
                onTap: () => Get.find<AuthController>().logout(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
