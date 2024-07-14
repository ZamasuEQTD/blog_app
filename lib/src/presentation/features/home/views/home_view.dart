import 'dart:developer';

import 'package:blog_app/src/domain/features/home/models/portada.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../logic/bloc/bloc/portadas_home_bloc.dart';
import '../widgets/filtros/filtros_de_portadas.dart';
import '../widgets/portada/cargando/portada_cargando.dart';
import '../widgets/portada/portada.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PortadasHomeBloc(GetIt.I.get())..add(CargarPortadasHome()))
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: const HomeViewBody(),
      ),
    );
  }
}

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  final ScrollController controller = ScrollController();
  @override
  void initState() {
    controller.addListener(() {
      if (_isBottom) {
        context.read<PortadasHomeBloc>().add(CargarPortadasHome());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics:const BouncingScrollPhysics(),
      controller: controller,
      slivers: const [
        SliverToBoxAdapter(
          child: FiltrosPortadasHome()
        ),
        PortadasHomeGridList()
      ],
    );
  }

  bool get _isBottom {
    if (!controller.hasClients) return false;

    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.offset;

    return currentScroll >= (maxScroll * 0.9);
  }
}

class PortadasHomeGridList extends StatelessWidget {
  const PortadasHomeGridList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PortadasHomeBloc, PortadasHomeState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.portadas.length != current.portadas.length,
      builder: (context, state) {
        List<Portada> portadas =[...state.portadas,...(state.status == PortadasHomeStatus.cargando? _cargando : [])];
        return SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 200,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                crossAxisCount: 2
            ),
            delegate: SliverChildBuilderDelegate(
              childCount:portadas.length,
              (context, index) {
              Portada portada = portadas[index];
              if (portada is PortadaHome) {
                return PortadaDeHiloHome(portada: portada);
              }
              return const PortadaDeHiloHomeCargando();
            }),
          ),
        );
         
      },
    );
  }

  static final _cargando = [for (var i = 0; i < 3; i += 1) const CargandoPortadaHome()];
}
