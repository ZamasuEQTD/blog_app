import 'package:blog_app/common/logic/extensions/scroll_controller.dart';
import 'package:blog_app/common/widgets/button/filled_icon_button.dart';
import 'package:blog_app/common/widgets/inputs/decorations/decorations.dart';
import 'package:blog_app/features/home/domain/abstractions/ihome_hub.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:badges/badges.dart' as badges;

import '../../domain/models/home_portada_entry.dart';
import '../logic/bloc/home_portadas_bloc.dart';
import '../widgets/portada/bottom_sheet/opciones_bottom_sheet.dart';
import 'widgets/portada_card.dart';

class HomeScreen extends StatefulWidget {
  static const SliverGridDelegate _delegate =
      SliverGridDelegateWithFixedCrossAxisCount(
    mainAxisExtent: 200,
    crossAxisSpacing: 5,
    mainAxisSpacing: 5,
    crossAxisCount: 2,
  );

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomePortadasBloc bloc = HomePortadasBloc(GetIt.I.get());
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    bloc.add(CargarPortadasHome());

    if (controller.isBottom()) {
      bloc.add(CargarPortadasHome());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
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
        appBar: AppBar(
          title: const Text(
            "Devox",
            style: TextStyle(
              color: Color(0xff5465FF),
              fontWeight: FontWeight.w900,
              fontSize: 25,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => context.push("/mis-notificaciones"),
              icon: badges.Badge(
                position: badges.BadgePosition.bottomEnd(bottom: -10, end: -12),
                badgeContent: const Text(
                  "5",
                  style: TextStyle(color: Colors.black),
                ),
                child: const FaIcon(
                  FontAwesomeIcons.bell,
                  color: Colors.black,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.bars),
            ),
          ],
          elevation: 0,
        ),
        body: CustomScrollView(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          slivers: const [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 10),
              sliver: SliverMainAxisGroup(
                slivers: [
                  _HomePortadasFiltros(),
                  _HomePortadasGrid(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.close();
    controller.dispose();
    super.dispose();
  }
}

class _HomePortadasGrid extends StatefulWidget {
  const _HomePortadasGrid({
    super.key,
  });

  @override
  State<_HomePortadasGrid> createState() => _HomePortadasGridState();
}

class _HomePortadasGridState extends State<_HomePortadasGrid> {
  final IHomeHub _hub = GetIt.I.get();

  @override
  void initState() {
    _hub.onHiloEliminado(
      (id) => context.read<HomePortadasBloc>().add(EliminarPortada(id: id)),
    );

    _hub.onHiloPosteado(
      (portada) => context
          .read<HomePortadasBloc>()
          .add(AgregarPortada(portada: portada)),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePortadasBloc, HomePortadasState>(
      builder: (context, state) {
        final int count = state.portadas.length +
            (state.status == PortadasHomeStatus.cargando ? 5 : 0);

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          sliver: SliverGrid.builder(
            itemCount: count,
            gridDelegate: HomeScreen._delegate,
            itemBuilder: (context, index) {
              if (index > state.portadas.length) {
                return const PortadaCard.cargando();
              }

              PortadaEntity entry = state.portadas[index];

              return GestureDetector(
                onTap: () => context.push("/hilo/${entry.id}"),
                onLongPress: () => OpcionesDePortadaBottomSheet.show(context),
                child: PortadaCard(portada: entry),
              );
            },
          ),
        );
      },
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

class _FiltrarPortadasPorTitulo extends StatefulWidget {
  const _FiltrarPortadasPorTitulo({
    super.key,
  });

  @override
  State<_FiltrarPortadasPorTitulo> createState() =>
      _FiltrarPortadasPorTituloState();
}

class _FiltrarPortadasPorTituloState extends State<_FiltrarPortadasPorTitulo> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        maxLines: 1,
        controller: controller,
        decoration: BusquedaInputDecoration(
          borderRadius: 10,
          hintText: "Titulo de hilo",
          onTap: () => context.read<HomePortadasBloc>().add(
                CambiarFiltrosDePortadas(titulo: controller.text),
              ),
        ).copyWith(
          fillColor: const Color(0xffF5F5F5),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
