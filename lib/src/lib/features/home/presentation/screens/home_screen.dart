import 'package:blog_app/src/lib/features/home/domain/models/home_portada.dart';
import 'package:blog_app/src/lib/features/home/presentation/screens/logic/blocs/home/home_bloc.dart';
import 'package:blog_app/src/lib/features/home/presentation/screens/widgets/portada.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../app/presentation/widgets/colored_icon_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        appBar: AppBar(),
        body: const CustomScrollView(
          slivers: [
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
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      sliver: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final int count = state.portadas.length +
              (state.portadasState is CargandoHomePortadasState ? 5 : 0);

          return SliverGrid.builder(
            itemCount: count,
            gridDelegate: _delegate,
            itemBuilder: (context, index) {
              if (index > state.portadas.length) {
                return const Portada.bone();
              }

              HomePortada entry = state.portadas[index];

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
        decoration: InputDecoration(
          hintText: "Buscar por titulo",
          suffixIcon: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          ),
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
