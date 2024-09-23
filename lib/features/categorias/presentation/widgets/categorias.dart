import 'package:blog_app/common/widgets/seleccionable/logic/class/grupo_seleccionable.dart';
import 'package:blog_app/common/widgets/seleccionable/logic/class/item_seleccionable.dart';
import 'package:blog_app/common/widgets/seleccionable/widget/grupo_seleccionable_list.dart';
import 'package:blog_app/features/categorias/domain/models/categoria.dart';
import 'package:blog_app/features/categorias/domain/models/subcategoria.dart';
import 'package:blog_app/features/categorias/presentation/widgets/subcategoria_background.dart';
import 'package:blog_app/features/media/presentation/logic/extensions/media_extensions.dart';

class SubcategoriaItem extends ItemSeleccionable {
  final String categoria;
  final Subcategoria subcategoria;
  SubcategoriaItem(this.subcategoria, this.categoria, {super.onTap})
      : super(
          nombre: subcategoria.nombre,
          leading: SubcategoriaImagen(
            provider: subcategoria.imagen.toProvider(),
          ),
        );
}

extension CategoriaExtensions on List<Categoria> {
  List<GrupoSeleccionable> generarGrupos() {
    List<GrupoSeleccionable> grupos = [];

    for (var c in this) {
      List<SubcategoriaItem> subcategorias = [];

      for (var s in c.subcategorias) {
        subcategorias.add(SubcategoriaItem(s, c.nombre));
      }

      grupos.add(
        GrupoSeleccionable(
          titulo: c.nombre,
          seleccionables: subcategorias,
        ),
      );
    }
    return grupos;
  }
}
