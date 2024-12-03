import 'package:blog_app/features/app/presentation/logic/extensions/scroll_controller_extension.dart';
import 'package:blog_app/features/app/presentation/widgets/colored_icon_button.dart';
import 'package:blog_app/features/home/domain/hub/ihome_portadas_hub.dart';
import 'package:blog_app/features/home/presentation/screens/widgets/home_filtros.dart';
import 'package:blog_app/modules/routing.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../logic/home_controller.dart';
import 'widgets/home_menu.dart';
import 'widgets/home_portadas_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //late IPortadasHub hub = GetIt.I.get();

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
      if (l != null) {}
    });

    //hub.connect();

    //hub.onHiloPosteado.listen(
    //  (portada) => controller.agregarPortada(portada),
    //);

    //hub.onHiloEliminado.listen((id) => controller.eliminarPortada(id));

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
          HomeFiltros(),
          HomePortadasGrid(),
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
