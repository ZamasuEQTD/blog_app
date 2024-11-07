import 'package:blog_app/src/lib/features/app/presentation/extensions/scroll_controller_extensions.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/dialogs/bottom_sheet.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/grupo_seleccionable.dart';
import 'package:blog_app/src/lib/features/app/presentation/widgets/item_seleccionable.dart';
import 'package:blog_app/src/lib/features/auth/presentation/logic/controlls/auth_controller.dart';
import 'package:blog_app/src/lib/features/hilo/domain/ihilos_repository.dart';
import 'package:blog_app/src/lib/features/home/data/development/home_local_hub.dart';
import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:blog_app/src/lib/features/home/domain/hub/ihome_portadas_hub.dart';
import 'package:blog_app/src/lib/features/home/presentation/screens/logic/home_controller.dart';
import 'package:blog_app/src/lib/features/home/presentation/screens/widgets/portada.dart';
import 'package:blog_app/src/lib/features/moderacion/presentation/ver_usuario_panel.dart';
import 'package:blog_app/src/lib/features/usuarios/domain/models/usuario.dart';
import 'package:blog_app/src/lib/modules/routing.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../app/presentation/widgets/colored_icon_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late IHomePortadasHub hub = HomeLocalHub();

  HomeController controller = Get.put(HomeController())..cargarPortadas();

  final ScrollController scroll = ScrollController();

  @override
  void initState() {
    scroll.addListener(
      () {
        if (scroll.IsBottom) controller.cargarPortadas();
      },
    );

    hub.connect();

    hub.onHiloPosteado.listen((portada) => controller.agregarPortada(portada));

    hub.onHiloEliminado.listen((id) => controller.eliminar(id));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: () => context.push(Routes.notificaciones),
            icon: const Icon(Icons.notifications),
            label: const Text("99+"),
          ),
        ],
      ),
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
            itemCount: controller.portadas.value.length +
                (controller.cargando.value ? 5 : 0),
            gridDelegate: _delegate,
            itemBuilder: (context, index) {
              if (index >= controller.portadas.value.length) {
                return const Portada.bone();
              }

              HomePortada entry = controller.portadas.value[index];

              return GestureDetector(
                onLongPress: () => showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return HomePortadaOpciones(portada: entry);
                  },
                ),
                onTap: () => context.push("/hilo/${entry.id}"),
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
        onChanged: (value) => controller.titulo.value = value,
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

class HomePortadaOpciones extends StatelessWidget {
  final HomePortada portada;
  const HomePortadaOpciones({super.key, required this.portada});

  @override
  Widget build(BuildContext context) {
    return RoundedBottomSheet.normal(
      child: Column(
        children: [
          GrupoSeleccionable(
            seleccionables: [
              ItemSeleccionable.text(
                titulo: "Seguir",
                onTap: () async {
                  var res = await GetIt.I
                      .get<IHilosRepository>()
                      .seguir(id: portada.id);

                  res.fold((l) => null, (r) => null);
                },
              ),
              ItemSeleccionable.text(
                titulo: "Poner en favoritos",
                onTap: () async {
                  var res = await GetIt.I
                      .get<IHilosRepository>()
                      .ponerEnFavoritos(id: portada.id);

                  res.fold((l) => null, (r) => null);
                },
              ),
              ItemSeleccionable.text(
                titulo: "Ocultar",
                onTap: () async {
                  var res = await GetIt.I.get<IHilosRepository>().ocultar(
                        id: portada.id,
                      );

                  res.fold((l) => null, (r) => null);
                },
              ),
              ItemSeleccionable.text(titulo: "Denunciar", onTap: () => {}),
            ],
          ),
          if (Get.find<AuthController>().usuario.value?.rango is Moderador)
            GrupoSeleccionable(
              seleccionables: [
                ItemSeleccionable.text(
                  titulo: "Ver usuario",
                  onTap: () => showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    builder: (context) => const VerUsuarioPanelBottomSheet(),
                  ),
                ),
                ItemSeleccionable.text(
                  titulo: "Eliminar",
                  onTap: () async {
                    var res = await GetIt.I.get<IHilosRepository>().eliminar(
                          id: portada.id,
                        );

                    res.fold((l) => null, (r) => null);
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
