// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:blog_app/src/lib/features/postear_hilo/presentation/blocs/postear_hilo/postear_hilo_bloc.dart';

import '../../media/presentation/logic/blocs/gestor_de_media/gestor_de_media_bloc.dart';
import '../../media/presentation/multi_media.dart';

class PostearHiloScreen extends StatelessWidget {
  const PostearHiloScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PostearHiloBloc(),
        ),
        BlocProvider(
          create: (context) => GestorDeMediaBloc(),
        ),
      ],
      child: BlocListener<PostearHiloBloc, PostearHiloState>(
        listenWhen: (previous, current) => previous.hiloId != current.hiloId,
        listener: (context, state) {
          context.push("/hilo/${state.hiloId}");
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: const BackButton(
              color: Colors.black,
            ),
            title: const Text(
              "Postear hilo",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => context.read<PostearHiloBloc>().add(
                      PostearHilo(),
                    ),
                child: const Text(
                  "Postear",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: [
              const TextField(
                decoration: InputDecoration(
                  hintText: "Titulo",
                ),
              ),
              const TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Descripción",
                ),
              ),
              BlocBuilder<GestorDeMediaBloc, GestorDeMediaState>(
                builder: (context, state) {
                  if (state.medias.isEmpty) {
                    return SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Agregar portadas"),
                      ),
                    );
                  }
                  return MultiMedia(media: state.medias[0]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

abstract class PostearHiloLabelSection extends StatelessWidget {
  const PostearHiloLabelSection._({super.key});

  const factory PostearHiloLabelSection({
    Key? key,
    required String text,
  }) = _PostearHiloLabelSection;
}

class _PostearHiloLabelSection extends PostearHiloLabelSection {
  final String text;

  const _PostearHiloLabelSection({super.key, required this.text}) : super._();
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color.fromRGBO(73, 80, 87, 1),
      ),
    );
  }
}
