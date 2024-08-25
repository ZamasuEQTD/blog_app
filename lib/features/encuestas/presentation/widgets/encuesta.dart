import 'dart:math';

import 'package:blog_app/features/encuestas/domain/models/encuesta.dart';
import 'package:blog_app/features/encuestas/presentation/logic/bloc/encuesta_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EncuestaWidget extends StatelessWidget {
  final Encuesta encuesta;
  const EncuestaWidget({super.key, required this.encuesta});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EncuestaBloc(encuesta),
      child: Column(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: encuesta.opciones
                .map((o) => _OpcionDeEncuesta(
                    opcion: o, votosTotales: encuesta.votos()))
                .toList(),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              BlocBuilder<EncuestaBloc, EncuestaState>(
                buildWhen: (previous, current) =>
                    previous.encuesta.votos() != current.encuesta.votos(),
                builder: (context, state) {
                  return Text('${encuesta.votos()}');
                },
              ),
              ElevatedButton(
                  onPressed: () =>
                      context.read<EncuestaBloc>().add(const Votar()),
                  child: const Text("Votar"))
            ],
          )
        ],
      ),
    );
  }
}

class _OpcionDeEncuesta extends StatelessWidget {
  final int votosTotales;
  final OpcionDeEncuesta opcion;

  const _OpcionDeEncuesta(
      {super.key, required this.opcion, required this.votosTotales});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: () =>
            context.read<EncuestaBloc>().add(SeleccionarOpcion(id: opcion.id)),
        child: SizedBox(
          height: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    return ColoredBox(
                      color: Colors.red,
                      child: SizedBox(
                        width: constraints.maxWidth *
                            (opcion.porcentaje(votosTotales) / 100),
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
                      Text(opcion.opcion),
                      Row(
                        children: [
                          Text(opcion.porcentaje(votosTotales).toString()),
                          Text(opcion.porcentaje(votosTotales).toString())
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
