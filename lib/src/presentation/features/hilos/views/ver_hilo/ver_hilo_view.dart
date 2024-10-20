import 'package:blog_app/src/domain/features/hilos/models/types/hilo_id.dart';
import 'package:blog_app/src/presentation/features/hilos/views/ver_hilo/widgets/body/hilo_body.dart';
import 'package:blog_app/src/presentation/features/hilos/views/ver_hilo/widgets/comentarios/comentarios_de_hilo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'logic/bloc/ver_hilo/ver_hilo_bloc.dart';
import 'widgets/comentarios/logic/bloc/comentarios_de_hilo/comentarios_de_hilo_bloc.dart';

class VerHiloView extends StatelessWidget {
  final HiloId hiloId;
  const VerHiloView({super.key, required this.hiloId});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: VerHiloBody(),
    );
  }
}

class VerHiloBody extends StatelessWidget {
  const VerHiloBody({super.key});

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
      create: (context) => ScrollController(),
      builder:(context, child) => 
        SingleChildScrollView(
          controller: context.read(),
          child: BlocBuilder<VerHiloBloc, VerHiloState>(
            builder:  _builder,
          )
        )
    );
  }

  Widget _builder(BuildContext context, VerHiloState state) {
    if(state is! HiloCargado){
      return Container();
    }
    return Column(
      children: [
        HiloBody(hilo: state.hilo),
        BlocProvider(
          create: (context) => ComentariosDeHiloBloc(
            state.hilo.id
          )..add(
            const CargarComentarios()
          ),
          child: const ComentariosDeHilo(),
        )
      ],
    );
  }
}
