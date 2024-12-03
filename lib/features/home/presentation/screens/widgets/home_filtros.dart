import 'package:blog_app/features/app/presentation/widgets/colored_icon_button.dart';
import 'package:blog_app/features/categorias/presentation/seleccionar_subcategoria_bottom_sheet.dart';
import 'package:blog_app/features/home/presentation/logic/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomeFiltros extends StatelessWidget {
  const HomeFiltros({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const HomeTituloInput(),
            const SizedBox(
              width: 10,
            ),
            ColoredIconButton(
              background: const Color(0xffF5F5F5),
              onPressed: () => SeleccionarSubcategoriaBottomSheet.show(
                context,
                onSubcategoriaSeleccionada: (subcategoria) =>
                    Get.find<HomeController>().subcategoria.value =
                        subcategoria,
              ),
              icon: const FaIcon(FontAwesomeIcons.box),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTituloInput extends StatefulWidget {
  const HomeTituloInput({super.key});

  @override
  State<HomeTituloInput> createState() => _HomeTituloInputState();
}

class _HomeTituloInputState extends State<HomeTituloInput> {
  final TextEditingController titulo = TextEditingController();

  HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
        controller: titulo,
        decoration: InputDecoration(
          hintText: "Buscar por titulo",
          suffixIcon: IconButton(
            onPressed: () => controller.titulo.value = titulo.text,
            icon: const Icon(
              Icons.search_outlined,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
