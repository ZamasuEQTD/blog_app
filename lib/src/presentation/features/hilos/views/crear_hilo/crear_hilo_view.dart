import 'package:blog_app/src/domain/features/categorias/models/subcategoria.dart';
import 'package:blog_app/src/domain/features/media/models/fuente_de_archivo.dart';
import 'package:blog_app/src/domain/features/media/models/media.dart';
import 'package:blog_app/src/presentation/common/widgets/bottom_sheet/rounded_bottom_sheet.dart';
import 'package:blog_app/src/presentation/common/widgets/buttons/flat_button.dart';
import 'package:blog_app/src/presentation/common/widgets/inputs/flat_input.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../encuestas/common/crear_encuesta/logic/bloc/crear/crear_encuesta_bloc.dart';
import 'logic/bloc/bloc/crear_hilo_bloc.dart';
import 'widgets/form/banderas.dart';
import 'widgets/form/crear_hilo_form.dart';
import 'widgets/form/portada.dart';

class CrearHiloView extends StatelessWidget {
  const CrearHiloView({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CrearHiloBloc(),
      child: ChangeNotifierProvider(
        create: (context) => ScrollController(),
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Crear hilo",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.arrow_left)),
              actions: [
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Crear",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ))
              ],
            ),
            body: const CrearHiloViewBody()),
      ),
    );
  }
}

class CrearHiloViewBody extends StatelessWidget {
  const CrearHiloViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: context.read(),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            CrearHiloForm(),
            SizedBox(height: 5),
            PortadaDeHilo(),
            SizedBox(height: 5),
            SeleccionarSubcategoria(),
            SizedBox(height: 5),
            ConfiguracionDeBanderas(),
            SizedBox(height: 5),
            EncuestaDeHilo()
          ],
        ),
      ),
    );
  }
}

class SeleccionarSubcategoria extends StatelessWidget {
  const SeleccionarSubcategoria({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        onTap: () {
          SeleccionarSubcategoriaBottomSheet.show(context);
        },
        title: const Text("Gore"),
        trailing: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: const SizedBox(
            height: 50,
            width: 50,
            child: Image(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696")),
          ),
        ),
      ),
    );
  }
}

class EncuestaDeHilo extends StatelessWidget {
  const EncuestaDeHilo({super.key});

  @override
  Widget build(BuildContext context) {
    SizedBox(
      height: 45,
      child: FlatBtn(
          borderRadius: 5,
          backgroundColor: Colors.white,
          child: const Row(mainAxisSize: MainAxisSize.min, children: [
            Text(
              "Agregar encuesta",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5),
            Icon(CupertinoIcons.chart_bar)
          ])),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Encuesta",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            OpcionesDeEncuesta(),
          ],
        ),
      ),
    );
  }
}

class OpcionesDeEncuesta extends StatelessWidget {
  const OpcionesDeEncuesta({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: context.read(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (context, index) {
        return OpcionDeEncuesta(
          index: index,
        );
      },
    );
  }
}

class OpcionDeEncuesta extends StatefulWidget {
  final int index;
  const OpcionDeEncuesta({
    super.key,
    required this.index,
  });

  @override
  State<OpcionDeEncuesta> createState() => _OpcionDeEncuestaState();
}

class _OpcionDeEncuestaState extends State<OpcionDeEncuesta> {
  late final TextEditingController controller;
  late final CrearEncuestaBloc bloc;
  @override
  void initState() {
    // bloc = context.read();

    controller = TextEditingController(
        // text:bloc.state.encuesta[widget.index]
        );

    // controller.addListener(() {
    //   bloc.add(
    //     CambiarOpcion(idx: widget.index, opcion: controller.text)
    //   );
    // });

    // bloc.stream.listen((event) {
    //   log(event.encuesta.toString());
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: InputFlatField(
                controller: controller, hintText: "opcion ${widget.index + 1}"),
          ),
          const SizedBox(width: 5),
          IconButton(
              onPressed: () {}, icon: const Icon(CupertinoIcons.trash_fill))
        ],
      ),
    );
  }
}

class SeleccionarSubcategoriaBottomSheet extends StatelessWidget {
  const SeleccionarSubcategoriaBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GrupoSeleccionableList(
        seleccionables: [
          GrupoSeleccionable(seleccionables: [
          SubcategoriaSeleccionableTile(subcategoria: Subcategoria("id", "nombre", Imagen(NetworkMedia("")))),
          SubcategoriaSeleccionableTile(subcategoria: Subcategoria("id", "nombre", Imagen(NetworkMedia("")))),
          SubcategoriaSeleccionableTile(subcategoria: Subcategoria("id", "nombre", Imagen(NetworkMedia("")))),
          SubcategoriaSeleccionableTile(subcategoria: Subcategoria("id", "nombre", Imagen(NetworkMedia(""))))
        ])]);
  }

  static void show(BuildContext context) => 
  RoundedBottomSheetManager.show(
    context: context, child: const SeleccionarSubcategoriaBottomSheet()
  );
}

class SubcategoriaSeleccionableTile extends ItemSeleccionable {
  final Subcategoria subcategoria;
  SubcategoriaSeleccionableTile({required this.subcategoria})
      : super(
            nombre: subcategoria.nombre,
            trailing: const SubcategoriaTileImage( ));
}

class SubcategoriaTileImage extends StatelessWidget {
  const SubcategoriaTileImage({super.key});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: const SizedBox(
          height: 40,
          width: 40,
          child: Image(
            image: NetworkImage(
                "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"),
            fit: BoxFit.cover,
          )),
    );
  }
}
