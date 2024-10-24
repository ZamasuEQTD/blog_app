// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/models/encuesta.dart';
import 'blocs/bloc/encuesta_bloc.dart';

class EncuestaCard extends StatelessWidget {
  final Encuesta encuesta;

  const EncuestaCard({super.key, required this.encuesta});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EncuestaBloc(encuesta),
      child: Column(
        children: [
          ...encuesta.respuestas.map(
            (r) => _Respuesta(
              respuesta: r,
            ),
          ),
          Row(
            children: [
              BlocBuilder<EncuestaBloc, EncuestaState>(
                builder: (context, state) {
                  return Text("Votos ${state.encuesta.votos}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Respuesta extends StatelessWidget {
  final Respuesta respuesta;
  const _Respuesta({
    super.key,
    required this.respuesta,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GestureDetector(
        onTap: () => context.read(),
        child: SizedBox(
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return ColoredBox(
                      color: Colors.grey,
                      child: SizedBox(
                        width: constraints.maxWidth *
                            (respuesta.porcentaje(
                                  context
                                      .read<EncuestaBloc>()
                                      .state
                                      .encuesta
                                      .votos,
                                ) /
                                100),
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(respuesta.toString()),
                      Row(
                        children: [
                          Text(
                            respuesta
                                .porcentaje(
                                  context
                                      .read<EncuestaBloc>()
                                      .state
                                      .encuesta
                                      .votos,
                                )
                                .toString(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
