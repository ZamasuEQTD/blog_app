// ignore_for_file: unused_element
import 'dart:collection';

import 'package:blog_app/features/auth/presentation/widgets/bottom_sheet/sesion_requerida_bottomsheet.dart';
import 'package:blog_app/features/hilos/presentation/screens/hilo/widgets/comentario/comentario_card.dart';
import 'package:blog_app/features/media/presentation/logic/bloc/bloc/gestor_de_media_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/models/comentario.dart';
import '../../../domain/models/hilo.dart';
import '../../logic/bloc/hilo/comentar_hilo/comentar_hilo_bloc.dart';
import '../../logic/bloc/hilo/hilo_bloc.dart';

import '../../logic/controllers/taggueos_controller.dart';
import '../../../../auth/presentation/widgets/bottom_sheet/bottom_sheet.dart';
import 'widgets/comentar_hilo_bottom_sheet/comentar_hilo.dart';
import 'widgets/informacion/hilo_informacion.dart';

class HiloScreen extends StatelessWidget {
  final HiloId id;
  const HiloScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaggueosController()),
        ChangeNotifierProvider(create: (_) => WidgetAlturaController()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ComentarHiloBloc()),
          BlocProvider(
            create: (context) => HiloBloc(id)..add(CargarHilo()),
          ),
          BlocProvider(create: (_) => GestorDeMediaBloc()),
        ],
        child: Scaffold(
          body: BlocBuilder<HiloBloc, HiloState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: state.status == HiloStatus.cargado
                    ? [
                        HiloInformacion(hilo: state.hilo!),
                        SliverPadding(
                          padding: EdgeInsets.only(
                            bottom:
                                context.watch<WidgetAlturaController>().height,
                          ),
                          sliver: const _Comentarios(),
                        ),
                      ]
                    : [
                        const SliverToBoxAdapter(),
                      ],
              );
            },
          ),
          bottomSheet: BlocBuilder<HiloBloc, HiloState>(
            builder: (context, state) {
              if (state.status == HiloStatus.cargado) {
                return const ComentarHiloBottomSheet();
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class _Comentarios extends StatefulWidget {
  const _Comentarios();

  @override
  State<_Comentarios> createState() => _ComentariosState();
}

class _ComentariosState extends State<_Comentarios> {
  final HashMap<ComentarioId, GlobalKey> _keys = HashMap();

  static const Widget _cargando = ComentarioCardCargando();

  @override
  void initState() {
    context.read<HiloBloc>().add(CargarComentarios());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverMainAxisGroup(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: BlocBuilder<HiloBloc, HiloState>(
              builder: (context, state) {
                return Text(
                  "Comentarios (${state.hilo!.comentarios})",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ),
        ),
        BlocListener<HiloBloc, HiloState>(
          listenWhen: (previous, current) =>
              previous.comentarios.length != current.comentarios.length,
          listener: (context, state) {
            for (var c in state.comentarios) {
              if (c is! ComentarioModel) return;

              if (_keys[c.id] == null) {
                _keys[c.id] = GlobalKey();
              }
            }
          },
          child: BlocBuilder<HiloBloc, HiloState>(
            buildWhen: (previous, current) =>
                previous.comentarios.length != current.comentarios.length,
            builder: (context, state) {
              final List<ComentarioEntry> comentarios = state.comentarios;
              return SliverList.builder(
                itemCount: comentarios.length,
                itemBuilder: (context, index) {
                  ComentarioEntry comentario = comentarios[index];
                  switch (comentario) {
                    case ComentarioModel c:
                      return ComentarioCard(
                        key: _keys[c.id],
                        comentario: comentario,
                      );
                    case ComentarioListCargandoEntry _:
                      return _cargando;
                    default:
                      throw Exception("");
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ComentarioCargando extends StatelessWidget {
  const _ComentarioCargando({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class OutlinedIcon extends StatelessWidget {
  final Widget child;
  const OutlinedIcon({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: const Color.fromRGBO(199, 199, 199, 1),
          width: 1.25,
        ),
      ),
      child: child,
    );
  }
}

class HiloScreenCargando extends StatelessWidget {
  const HiloScreenCargando({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer.zone(
      effect: null,
      enabled: false,
      child: SliverMainAxisGroup(
        slivers: [
          const SliverMainAxisGroup(
            slivers: [
              SliverToBoxAdapter(
                child: ColoredBox(
                  color: Color(0xfff5f5f5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Bone(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          height: 200,
                          width: double.infinity,
                        ),
                      ),
                      Bone.text(
                        words: 3,
                        style: TextStyle(fontSize: 20),
                      ),
                      Bone.multiText(
                        lines: 4,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Bone.text(
                style: TextStyle(fontSize: 25),
                words: 2,
              ),
            ),
          ),
          SliverMainAxisGroup(
            slivers: List.generate(
              10,
              (index) =>
                  const SliverToBoxAdapter(child: ComentarioCardCargando()),
            ),
          ),
        ],
      ),
    );
  }
}
