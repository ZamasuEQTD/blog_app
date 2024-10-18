import 'package:equatable/equatable.dart';

import 'subcategoria.dart';

class Categoria extends Equatable {
  final String nombre;
  final List<SubcategoriaEntity> subcategorias;

  const Categoria(
    this.nombre,
    this.subcategorias,
  );

  @override
  List<Object?> get props => [
        nombre,
        subcategorias,
      ];
}
