import 'package:blog_app/src/lib/features/media/presentation/extensions/media_extensions.dart';
import 'package:flutter/material.dart';

import '../../app/presentation/widgets/item_seleccionable.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../domain/models/subcategoria.dart';

abstract class SubcategoriaTile extends StatelessWidget {
  const SubcategoriaTile._({super.key});

  const factory SubcategoriaTile({
    void Function()? onTap,
    Widget? trailing,
    required Subcategoria subcategoria,
  }) = _Subcategorias;

  const factory SubcategoriaTile.bone() = _SubcategoriaCargando;

  const factory SubcategoriaTile.base({required Widget child}) =
      _SubcategoriaBase;
}

class _SubcategoriaCargando extends SubcategoriaTile {
  const _SubcategoriaCargando({super.key}) : super._();

  @override
  Widget build(BuildContext context) {
    return const SubcategoriaTile.base(
      child: ItemSeleccionable(
        leading: ImagenSubcategoria.bone(),
        titulo: Bone.text(
          words: 1,
        ),
      ),
    );
  }
}

class _SubcategoriaBase extends SubcategoriaTile {
  final Widget child;
  const _SubcategoriaBase({
    required this.child,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Colors.white,
        child: child,
      ),
    );
  }
}

class _Subcategorias extends SubcategoriaTile {
  final Widget? trailing;
  final void Function()? onTap;
  final Subcategoria subcategoria;

  const _Subcategorias({
    this.trailing,
    this.onTap,
    required this.subcategoria,
  }) : super._();

  @override
  Widget build(BuildContext context) {
    return SubcategoriaTile.base(
      child: ItemSeleccionable(
        onTap: onTap,
        leading: ImagenSubcategoria.image(
          image: subcategoria.imagen.toProvider,
        ),
        titulo: Text(
          subcategoria.nombre,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        trailing: trailing,
      ),
    );
  }
}

abstract class ImagenSubcategoria extends StatelessWidget {
  const ImagenSubcategoria._({super.key});

  const factory ImagenSubcategoria.base({required Widget child}) =
      _ImagenSubcategoria;

  const factory ImagenSubcategoria.image({
    required ImageProvider image,
  }) = _ImagenSubcategoriaCargada;

  const factory ImagenSubcategoria.bone() = _ImagenSubcategoriaCargando;
}

class _ImagenSubcategoria extends ImagenSubcategoria {
  final Widget child;
  const _ImagenSubcategoria({
    required this.child,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: SizedBox(
        height: 35,
        width: 35,
        child: child,
      ),
    );
  }
}

class _ImagenSubcategoriaCargada extends ImagenSubcategoria {
  final ImageProvider image;
  const _ImagenSubcategoriaCargada({
    required this.image,
  }) : super._();
  @override
  Widget build(BuildContext context) {
    return ImagenSubcategoria.base(
      child: Image(
        image: image,
        fit: BoxFit.cover,
      ),
    );
  }
}

class _ImagenSubcategoriaCargando extends ImagenSubcategoria {
  const _ImagenSubcategoriaCargando() : super._();

  @override
  Widget build(BuildContext context) {
    return const Expanded(child: Bone());
  }
}
