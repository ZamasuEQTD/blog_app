
import 'dart:developer';

import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
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
    return SeleccionableSheet(
      grupo: GrupoSeleccionable(seleccionables: [
        ItemSeleccionable(
          nombre: "Dados",
          onTap: ()=> _changeDados(context),
          trailing: Checkbox(value: state.banderas.dados, onChanged: (value)=> _changeDados(context)) 
        ),
        ItemSeleccionable(
          onTap: () => _changeIdUnico(context),
          nombre: "Tag unico",
          trailing: Checkbox(
            value: state.banderas.tagUnico, 
            onChanged:(value) =>  _changeIdUnico(context))
          )
      ])
    );
  }

  void _changeDados(BuildContext context){
    CrearHiloBloc bloc = context.read();
    bloc.add(CambiarBanderas(dados: !bloc.state.banderas.dados));
  }
  void _changeIdUnico(BuildContext context) {
    CrearHiloBloc bloc = context.read();
    bloc.add(CambiarBanderas(tagUnico: !bloc.state.banderas.tagUnico));
  }
}
