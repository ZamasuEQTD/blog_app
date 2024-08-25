import 'package:equatable/equatable.dart';

import '../../../media/domain/models/media.dart';

class Subcategoria extends Equatable {
  final SubcategoriaId id;
  final String nombre;
  final Imagen imagen;

  const Subcategoria(this.id, this.nombre, this.imagen);

  @override
  List<Object?> get props => [id];
}

typedef SubcategoriaId = String;
