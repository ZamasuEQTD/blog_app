import 'package:blog_app/src/presentation/common/widgets/bottom_sheet/rounded_bottom_sheet.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import 'package:blog_app/src/presentation/common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import 'package:blog_app/src/presentation/features/auth/views/login/login_view.dart';
import 'package:blog_app/src/presentation/features/hilos/views/crear_hilo/widgets/bottom_sheet/opciones_de_portada/opciones_de_portada_bottom_sheet.dart';
import 'package:flutter/material.dart';

class PortadaDeHilo extends StatelessWidget {
  const PortadaDeHilo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        padding: const EdgeInsets.all(5),
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Portada",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const PortadaContainer(),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

class PortadaContainer extends StatelessWidget {
  const PortadaContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: double.infinity,
      child: ElevatedButton(
        style:   NormalButtonStyle(),
        onPressed:() {
          AgregarPortadaOpcionesBottomSheet.show(context);
        }, 
        child: const Text(
          "Agregar portada"
        )
      ),
    );
    



    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        OpcionesDePortadaBottomSheet.show(context);
      },
      child: Stack(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const Image(
                  image: NetworkImage(
                      "https://preview.redd.it/evie-templeton-is-portraying-laura-in-sh2-remake-and-the-v0-mc2fhcpkwq3d1.jpg?width=1080&crop=smart&auto=webp&s=a19290370f885c41d28cd175d03da150db609696"))),
        ],
      ),
    );
  }
}

class AgregarPortadaOpcionesBottomSheet extends StatelessWidget {
  const AgregarPortadaOpcionesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GrupoSeleccionableList(seleccionables: const [
      GrupoSeleccionable(
        nombre: "Agregar portada",
        seleccionables: [
        ItemSeleccionable(nombre: "Agregar desde enlace"),
        ItemSeleccionable(nombre: "Agregar desde galeria"),
      ])
    ]);
  }

  static void show(BuildContext context){
    RoundedBottomSheetManager.show(context: context, child: const AgregarPortadaOpcionesBottomSheet());
  }
}