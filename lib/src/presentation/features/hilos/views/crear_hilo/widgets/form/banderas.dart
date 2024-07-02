import 'package:blog_app/src/presentation/features/hilos/views/crear_hilo/logic/bloc/bloc/crear_hilo_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ConfiguracionDeBanderas extends StatelessWidget {
  const ConfiguracionDeBanderas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Banderas",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                BlocBuilder<CrearHiloBloc, CrearHiloState>(
                buildWhen: (previous, current) => previous.banderas != current.banderas,
                  builder: _builder,
                )
                
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _builder(BuildContext context, CrearHiloState state) {
    final CrearHiloBloc bloc = context.read();
    return Column(
      children: [
          _getTile(
            "Dados", 
            state.banderas.dados,
            (value) {
              bloc.add(CambiarBanderas(
                dados: value
              ));
            }
          ),
          _getTile(
            "Tag unico",
            state.banderas.tagUnico,
            (value) {
              bloc.add(CambiarBanderas(tagUnico: value));
            },
          )
        ],
    );
  }


  ListTile _getTile(String title, bool value, void Function(bool? value) onChanged){
    return ListTile(
      title: Text(title),
      trailing: Checkbox(
          value: value,
          onChanged: onChanged
      )
    );
  }
}
