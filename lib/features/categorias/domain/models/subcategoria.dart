import 'package:equatable/equatable.dart';

import '../../../media/domain/models/media.dart';

class SubcategoriaEntity extends Equatable {
  final SubcategoriaId id;
  final String nombre;
  final Imagen imagen;

  const SubcategoriaEntity(this.id, this.nombre, this.imagen);

  @override
  List<Object?> get props => [id];
}

typedef SubcategoriaId = String;
