import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/bloc/historial_de_hilos_bloc.dart';

class HistorialDeHilosPosteados extends StatelessWidget {
  const HistorialDeHilosPosteados({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistorialDeHilosBloc, HistorialDeHilosState>(
      builder: (context, state) {
        return Container();
      },
    );
  }
}
