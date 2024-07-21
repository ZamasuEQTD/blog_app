import 'dart:developer';

import 'package:blog_app/common/logic/extensions/scroll_controller.dart';
import 'package:blog_app/domain/features/home/entities/home_portada_de_hilo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../logic/bloc/portadas/portadas_home_bloc.dart';
import '../widgets/filtros/filtros_de_portadas.dart';
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
      if (controller.isBottom()) {
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
        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 10),
          sliver: SliverMainAxisGroup(slivers: [
            SliverToBoxAdapter(child: FiltrosPortadasHome()),
            PortadasHomeGridList()
          ])
        )
      ],
    );
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
        List<HomePortadaDeHilo> portadas = state.portadas;
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
                return HomePortada(
                  portada: portadas[index],
                );
            }),
          ),
        );
      },
    );
  }
}
