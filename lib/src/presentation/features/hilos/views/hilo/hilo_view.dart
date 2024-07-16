import 'dart:collection';
import 'package:blog_app/src/presentation/features/hilos/logic/comentarios/comentarios_bloc.dart';
import 'package:blog_app/src/presentation/features/hilos/logic/hilo/hilo_bloc.dart';
import 'package:blog_app/src/presentation/features/hilos/widgets/comentar_hilo/comentar_hilo.dart';
import 'package:blog_app/src/presentation/features/hilos/widgets/hilo/cargando/hilo_view_cargando.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import '../../widgets/comentarios/comentario/cargando/comentario_cargando.dart';
import '../../widgets/comentarios/comentario/comentario.dart';
import '../../widgets/hilo/hilo_body/hilo_body.dart';

class HiloView extends StatelessWidget {
  const HiloView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TextEditingController(),
      child: BlocProvider(
      create: (context) => HiloBloc(GetIt.I.get())..add(CargarHilo()),
      child: const Scaffold(
        body: HiloViewBody(),
        bottomSheet: ComentarHilo()
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
              const ComentariosDeHilo(),
            ],
          );
        });
  }
}

class ComentariosDeHilo extends StatefulWidget {
  const ComentariosDeHilo({super.key});

  @override
  State<ComentariosDeHilo> createState() => _ComentariosDeHiloState();

}

class _ComentariosDeHiloState extends State<ComentariosDeHilo> {
  final HashMap<String, GlobalKey> _keys = HashMap();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ComentariosBloc, ComentariosState>(
      listener: (context, state) {
        for(var c in state.comentarios){
          if(!_keys.containsKey(c.id)){
            _keys[c.id] = GlobalKey();
          }
        }
      },
      child: BlocBuilder<ComentariosBloc, ComentariosState>(
          builder: (context, state) {
            List<ComentarioItem> comentarios = state.comentarios;
            return SliverList.builder(
              itemCount: comentarios.length,
              itemBuilder: (context, index) {
                ComentarioItem comentario = comentarios[index];
                
                if (comentario is ComentarioHilo) return ComentarioDeHiloWidget(key: _keys[comentario.id], comentario: comentario);
                
                return const CargandoComentarioHiloWidget();
              },
            );
        }),
    );
  }
}

