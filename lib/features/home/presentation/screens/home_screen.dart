import 'package:blog_app/common/logic/extensions/scroll_controller.dart';
import 'package:blog_app/common/widgets/button/filled_icon_button.dart';
import 'package:blog_app/common/widgets/inputs/decorations/decorations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../domain/models/home_portada_entry.dart';
import '../logic/bloc/home_portadas_bloc.dart';
import '../widgets/portada/home_portada.dart';
import '../widgets/portada/home_portada_cargando.dart';

class HomeScreen extends StatefulWidget {
  static const SliverGridDelegate _delegate =
      SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisExtent: 200,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          crossAxisCount: 2);
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
        appBar: AppBar(
          title: const Text(
            "Devox",
            style: TextStyle(
                color: Color(0xff5465FF),
                fontWeight: FontWeight.w900,
                fontSize: 25),
          ),
        ),
        body: CustomScrollView(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          slivers: const [
            SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 10),
              sliver: SliverMainAxisGroup(slivers: [
                _HomePortadasFiltros(),
                //portadas grid
                _HomePortadasGrid()
              ]),
            )
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

class _HomePortadasGrid extends StatelessWidget {
  static const Widget _cargando = HomePortadaCargando();

  const _HomePortadasGrid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomePortadasBloc, HomePortadasState>(
      builder: (context, state) {
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          sliver: SliverGrid.builder(
            itemCount: state.portadas.length,
            gridDelegate: HomeScreen._delegate,
            itemBuilder: (context, index) {
              HomePortadaEntry entry = state.portadas[index];
              switch (entry) {
                case HomePortadaListEntry portada:
                  return HomePortada(portada: portada);
                case CargandoHomePortadaListEntry _:
                  return _cargando;
                default:
                  throw ArgumentError("Tipo de portada no contemplado");
              }
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
                  onPressed: () {},
                  icon: const Icon(Icons.abc),
                )
              ],
            )));
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
            onTap: () => context
                .read<HomePortadasBloc>()
                .add(CambiarFiltrosDePortadas(titulo: controller.text))),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
