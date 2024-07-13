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
        BlocProvider(create: (context) => PortadasHomeBloc(GetIt.I.get()))
      ],
      child: Scaffold(
        body: HomeViewBody(),
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
      if(_isBottom){
        context.read<PortadasHomeBloc>().add(CargarPortadasHome());
      }
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FiltrosPortadasHome(),
          PortadasHomeGridList(
            controller: controller,
          )
        ],
      ),
    );
  }

  bool get _isBottom {
    if (controller.hasClients) return false;

    final maxScroll = controller.position.maxScrollExtent;
    final currentScroll = controller.offset;
    
    return currentScroll >= (maxScroll * 0.9);
  }
}

class PortadasHomeGridList extends StatelessWidget {
  final ScrollController controller;
  const PortadasHomeGridList({
    super.key, 
    required this.controller
  });

  @override
  Widget build(BuildContext context) {
     
    return BlocBuilder<PortadasHomeBloc, PortadasHomeState>(
      buildWhen: (previous, current) => previous.portadas.length != current.portadas.length,
      builder: (context, state) {
       List<Portada> portadas = [
          ...state.portadas,
          ...(state.status == PortadasHomeStatus.cargando ? _getCargandoPortadas() : [])
        ];
        return GridView.builder(
            controller: controller,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: portadas.length,
            itemBuilder: (context, index) {
              Portada portada = portadas[index];
              if (portada is PortadaHome) {
                return PortadaDeHiloHome(portada: portada);
              }
              return const PortadaDeHiloHomeCargando();
            });
      },
    );
  }
  
  List<Portada> _getCargandoPortadas() {
    return [for (var i = 0; i < 10; i += 1) const CargandoPortadaHome()];
  }
}



 