import 'package:blog_app/presentation/hilos/logic/bloc/hilo/hilo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../widgets/cargando/hilo_view/ver_hilo_view_cargando.dart';
import '../widgets/comentarios/comentarios.dart';
import '../widgets/hilo_body/hilo_body.dart';


class VerHiloView extends StatelessWidget {
  const VerHiloView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TextEditingController(),
      child: BlocProvider(
      create: (context) => HiloBloc(GetIt.I.get())..add(CargarHilo()),
      child: const Scaffold(
        body: HiloViewBody(),
        // bottomSheet: ComentarHilo()
      ),
      ),
    );
  }
}


class HiloViewBody extends StatelessWidget {
  const HiloViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HiloBloc, HiloState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          if (state.status != HiloStatus.cargado) return const HiloViewCargando();

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: HiloBody(hilo: state.hilo!),
              ),
              const ListaDeComentarios(),
            ],
          );
        });
  }
}