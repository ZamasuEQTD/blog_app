import 'package:blog_app/features/app/presentation/logic/extensions/scroll_controller_extension.dart';
import 'package:blog_app/features/app/presentation/widgets/colored_icon_button.dart';
import 'package:blog_app/features/auth/presentation/logic/controllers/auth_controller.dart';
import 'package:blog_app/features/categorias/presentation/seleccionar_subcategoria_bottom_sheet.dart';
import 'package:blog_app/features/home/domain/hub/ihome_hub.dart';
import 'package:blog_app/features/notificaciones/domain/inotificaciones_hub.dart';
import 'package:blog_app/features/notificaciones/domain/models/notificacion.dart';
import 'package:blog_app/features/notificaciones/presentation/logic/controles/mis_notificaciones_controller.dart';
import 'package:blog_app/modules/routing.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../logic/home_controller.dart';
import 'widgets/home_menu.dart';
import 'widgets/home_portadas_grid.dart';
import 'package:badges/badges.dart' as badges;

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
      appBar: HomeAppBar(scaffold: scaffoldKey),
      body: CustomScrollView(
        controller: scroll,
        slivers: const [
          HomePortadasGrid(),
        ],
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

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffold;

  const HomeAppBar({super.key, required this.scaffold});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppBar(
        actions: [
          IconButton(
            onPressed: () {
              SeleccionarSubcategoriaBottomSheet.show(
                context,
                onSubcategoriaSeleccionada: (subcategoria) {
                  context.push("/portadas/categoria/${subcategoria.id}");
                },
              );
            },
            icon: const FaIcon(
              Icons.apps,
              size: 18,
            ),
          ),
          IconButton(
            onPressed: () => context.push("/portadas/titulo"),
            icon: const FaIcon(
              FontAwesomeIcons.magnifyingGlass,
              size: 18,
            ),
          ),
          if (Get.find<AuthController>().isAuthenticated)
            const NotificacionButton(),
          IconButton(
            onPressed: () => scaffold.currentState?.openEndDrawer(),
            icon: const FaIcon(
              FontAwesomeIcons.bars,
              size: 18,
            ),
          ),
        ]
            .map(
              (e) => SizedBox.square(
                dimension: 40,
                child: e,
              ).marginSymmetric(horizontal: 2),
            )
            .toList(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class NotificacionButton extends StatefulWidget {
  const NotificacionButton({
    super.key,
  });

  @override
  State<NotificacionButton> createState() => _NotificacionButtonState();
}

class _NotificacionButtonState extends State<NotificacionButton> {
  final INotificacionesHub hub = GetIt.I.get();

  final controller = Get.put(MisNotificacionesController());

  @override
  void initState() {
    hub.onUsuarioNotificado.listen((noti) {
      controller.agregarNotificacion(noti);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => IconButton(
        onPressed: () => context.push(Routes.notificaciones),
        icon: badges.Badge(
          position: badges.BadgePosition.custom(top: -10, end: -16),
          badgeContent: SizedBox.square(
            dimension: 15,
            child: ColoredBox(
              color: const Color.fromRGBO(255, 59, 92, 1),
              child: badge,
            ),
          ),
          child: const FaIcon(
            FontAwesomeIcons.bell,
            size: 18,
          ),
        ),
      ),
    );
  }

  Widget get badge {
    return mostrarBadge
        ? const FittedBox(
            child: Text(
              "99+",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          )
        : const SizedBox();
  }

  bool get mostrarBadge => controller.cantidad!.value > 0;
}
