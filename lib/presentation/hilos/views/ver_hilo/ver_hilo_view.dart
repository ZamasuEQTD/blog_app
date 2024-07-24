import 'package:blog_app/data/features/hilo/hub/hilo_hub.dart';
import 'package:blog_app/domain/features/hilo/abstractions/hilo_hub.dart';
import 'package:blog_app/domain/features/hilo/entities/hilo.dart';
import 'package:blog_app/presentation/hilos/views/ver_hilo/logic/bloc/comentarios/comentarios_bloc.dart';
import 'package:blog_app/presentation/hilos/views/ver_hilo/logic/bloc/hilo/hilo_bloc.dart';
import 'package:blog_app/presentation/hilos/views/ver_hilo/widgets/comentar_hilo/comentar_hilo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'widgets/cargando/ver_hilo_view_cargando.dart';
import 'widgets/comentarios/comentarios.dart';
import 'widgets/hilo_body/hilo_body.dart';

class VerHiloView extends StatelessWidget {
  const VerHiloView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TextEditingController(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HiloBloc(GetIt.I.get())..add(CargarHilo()),
          ),
          BlocProvider(
            create: (context) => ComentariosBloc(GetIt.I.get()),
          ),
        ],
        child: const Scaffold(
          body: HiloViewBody(),
          bottomSheet: _ComentarHiloBottomSheet()
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
          if (state.status != HiloStatus.cargado) {
            return const HiloViewCargando();
          }

          return HiloViewCargado(hilo: state.hilo!);
        });
  }
}

class HiloViewCargado extends StatefulWidget {
  final Hilo hilo;
  const HiloViewCargado({
    super.key,
    required this.hilo,
  });

  @override
  State<HiloViewCargado> createState() => _HiloViewCargadoState();
}

class _HiloViewCargadoState extends State<HiloViewCargado> {
  late final IHiloHub hub;
  @override
  void initState() {
    hub = HiloHub(hiloId: widget.hilo.id);

    hub.onEliminado(() => context.read<HiloBloc>().add(EliminarHilo()));

    hub.onComentado((comentario) =>
        context.read<ComentariosBloc>().add(AgregarComentario(comentario)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: HiloBody(hilo: widget.hilo),
        ),
        const ListaDeComentarios(),
      ],
    );
  }
}

class _ComentarHiloBottomSheet extends StatelessWidget {
  const _ComentarHiloBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HiloBloc, HiloState>(
      builder: (context, state) {
        if(state.status == HiloStatus.cargado && state.hilo!.estado == EstadoDeHilo.activo){
           return const ComentarHiloBottomSheet().animate().moveY();
        }

        return const SizedBox();
      },
    );
  }
}

