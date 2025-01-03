import 'package:equatable/equatable.dart';

import '../../../media/domain/models/media.dart';

class Categoria extends Equatable {
  final String nombre;
  final List<Subcategoria> subcategorias;

  const Categoria(
    this.nombre,
    this.subcategorias,
  );

  @override
  List<Object?> get props => [
        nombre,
        subcategorias,
      ];

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      json["nombre"],
      List<Subcategoria>.from(
        json["subcategorias"].map(
          (e) => Subcategoria.fromJson(Map<String, dynamic>.from(e as Map)),
        ),
      ),
    );
  }
}

class Subcategoria extends Equatable {
  final SubcategoriaId id;
  final String nombre;
  final Imagen imagen;

  const Subcategoria({
    required this.id,
    required this.nombre,
    required this.imagen,
  });

  @override
  List<Object?> get props => [id];

  factory Subcategoria.fromJson(Map<String, dynamic> json) {
    return Subcategoria(
      id: json["id"],
      nombre: json["nombre"],
      imagen: Imagen.fromJson({
        "url": json["imagen"],
      }),
    );
  }
}

typedef SubcategoriaId = String;
