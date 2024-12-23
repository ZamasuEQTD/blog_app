import 'dart:async';
import 'dart:developer';

import 'package:blog_app/features/app/presentation/logic/extensions/scroll_controller_extension.dart';
import 'package:blog_app/features/app/presentation/widgets/colored_icon_button.dart';
import 'package:blog_app/features/home/domain/hub/ihome_hub.dart';
import 'package:blog_app/features/home/presentation/screens/widgets/home_filtros.dart';
import 'package:blog_app/modules/routing.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;
import '../logic/home_controller.dart';
import 'widgets/home_menu.dart';
import 'widgets/home_portadas_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late IHomeHub hub = GetIt.I.get();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  HomeController controller = Get.put(HomeController())..cargarPortadas();

  final ScrollController scroll = ScrollController();

  @override
  void initState() {
    hub.connect();

    hub.onHiloPosteado.listen((portada) {
      controller.agregarPortada(portada);
    });

    hub.onHiloEliminado.listen((id) => controller.eliminarPortada(id));

    scroll.addListener(
      () {
        if (scroll.isBottom) controller.cargarPortadas();
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: const Color.fromRGBO(242, 242, 242, 1),
      endDrawer: const HomeMenu(),
      body: CustomMaterialIndicator(
        edgeOffset: 20,
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 10));
        },
        child: CustomScrollView(
          controller: scroll,
          slivers: [
            SliverAppBar(
              pinned: true,
              actions: [
                IconButton(
                  onPressed: () => context.push("/notificaciones"),
                  icon: const badges.Badge(
                    badgeContent: Text("2"),
                    badgeStyle: badges.BadgeStyle(),
                    child: FaIcon(FontAwesomeIcons.bell),
                  ),
                ),
                IconButton(
                  onPressed: () => scaffoldKey.currentState?.openEndDrawer(),
                  icon: const FaIcon(FontAwesomeIcons.bars),
                ),
              ],
            ),
            const HomeFiltros(),
            const HomePortadasGrid(),
            const SliverFillRemaining(
              fillOverscroll: true,
            ),
          ],
        ),
      ),
      floatingActionButton: ColoredIconButton(
        border: BorderRadius.circular(10),
        background: const Color.fromRGBO(227, 227, 227, 1),
        onPressed: () => context.push("/postear-hilo"),
        icon: const Icon(
          FontAwesomeIcons.plus,
          size: 20,
          color: Color.fromRGBO(115, 115, 115, 1),
        ),
      ),
    );
  }
}
