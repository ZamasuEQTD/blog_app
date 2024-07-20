import 'package:blog_app/domain/features/media/entities/media.dart';
import 'package:equatable/equatable.dart';

class Subcategoria extends Equatable {
  final SubcategoriaId id;
  final String nombre;
  final Imagen imagen;
  
  const Subcategoria(
    this.id, 
    this.nombre, 
    this.imagen
  );
  
  @override
  List<Object?> get props => [id];
}

typedef SubcategoriaId = String;