import 'package:blog_app/features/media/presentation/logic/bloc/bloc/gestor_de_media_bloc.dart';
import 'package:blog_app/src/lib/features/categorias/presentation/subcategoria_tile.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/blocs/comentarios/comentarios_bloc.dart';
import 'package:blog_app/src/lib/features/hilo/presentation/widgets/banderas.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../media/presentation/multi_media.dart';
import '../domain/models/hilo.dart';
import 'blocs/comentar_hilo/comentar_hilo_bloc.dart';
import 'blocs/hilo/hilo_bloc.dart';
import 'widgets/acciones.dart';

class HiloScreen extends StatelessWidget {
  final String id;
  const HiloScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AlturaController(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GestorDeMediaBloc(),
          ),
          BlocProvider(
            create: (context) => ComentarHiloBloc(),
          ),
          BlocProvider(create: (context) => HiloBloc(id)..add(CargarHilo())),
          BlocProvider(
            create: (context) => ComentariosBloc(id),
          ),
        ],
        child: Scaffold(
          body: BlocBuilder<HiloBloc, HiloState>(
            builder: (context, state) {
              if (state.status != HiloStatus.cargado) {
                return Container(
                  margin: EdgeInsets.only(
                    bottom: context.watch<AlturaController>().altura,
                  ),
                  child: CustomScrollView(
                    slivers: [
                      InformacionDeHilo(hilo: state.hilo!),
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class HiloScreenCargando extends StatelessWidget {
  const HiloScreenCargando({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class InformacionDeHilo extends StatelessWidget {
  final Hilo hilo;
  const InformacionDeHilo({super.key, required this.hilo});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(7),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          color: Color(0xfff5f5f5),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BanderasDeHiloRow(hilo: hilo),
                SubcategoriaTile(subcategoria: hilo.categoria),
                HiloAccionesRow(
                  hilo: hilo,
                ),
                MultiMedia(
                  media: hilo.portada.spoileable,
                ),
                Text(
                  hilo.titulo,
                  style: const TituloStyle(),
                ),
                Text(
                  hilo.descripcion,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TituloStyle extends TextStyle {
  const TituloStyle() : super(fontSize: 29, fontWeight: FontWeight.w900);
}

class AlturaController extends ChangeNotifier {
  double altura = 0;

  void cambiar(double altura) {
    this.altura = altura;
    notifyListeners();
  }
}
