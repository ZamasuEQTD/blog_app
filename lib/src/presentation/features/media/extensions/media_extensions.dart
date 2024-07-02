import 'package:blog_app/src/domain/features/media/models/fuente_de_archivo.dart';
import 'package:blog_app/src/domain/features/media/models/media.dart';
import 'package:flutter/material.dart';

extension ImagenExtension on Imagen {
  ImageProvider toProvider() {
    FuenteDeArchivo fuente = this.fuente;
    if (fuente is MemoryFile) {
      return MemoryImage(fuente.bytes);
    }
    if (fuente is LocalFile) {
      return FileImage(fuente.file);
    }

    return NetworkImage((fuente as NetworkMedia).url); 
  }
}